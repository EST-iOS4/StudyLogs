/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {setGlobalOptions} = require("firebase-functions");
const {onRequest} = require("firebase-functions/https");
const logger = require("firebase-functions/logger");
const admin = require("firebase-admin");

const {FieldValue} = require("firebase-admin/firestore");
const serverTimestamp = () => FieldValue.serverTimestamp();

// Initialize Firebase Admin SDK
admin.initializeApp();

// For cost control, you can set the maximum number of containers that can be
// running at the same time. This helps mitigate the impact of unexpected
// traffic spikes by instead downgrading performance. This limit is a
// per-function limit. You can override the limit for each function using the
// `maxInstances` option in the function's options, e.g.
// `onRequest({ maxInstances: 5 }, (req, res) => { ... })`.
// NOTE: setGlobalOptions does not apply to functions using the v1 API. V1
// functions should each use functions.runWith({ maxInstances: 10 }) instead.
// In the v1 API, each function can only serve one request per container, so
// this will be the maximum concurrent request count.
setGlobalOptions({maxInstances: 10});

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// Search books in Firestore by title or author
exports.search = onRequest(async (request, response) => {
  try {
    // Enable CORS
    response.set("Access-Control-Allow-Origin", "*");
    response.set("Access-Control-Allow-Methods", "GET");
    response.set("Access-Control-Allow-Headers", "Content-Type");

    if (request.method === "OPTIONS") {
      response.status(204).send("");
      return;
    }

    if (request.method !== "GET") {
      response.status(405).send("Method Not Allowed");
      return;
    }

    const searchTerm = request.query.q;

    if (!searchTerm) {
      response.status(400).json({
        error: "검색어가 필요합니다. ?q=검색어 형식으로 요청해주세요.",
      });
      return;
    }

    logger.info("Searching for:", searchTerm);

    const db = admin.firestore();
    const booksRef = db.collection("books");

    // Firestore에서는 부분 문자열 검색이 제한적이므로
    // 대소문자를 구분하지 않는 검색을 위해 소문자로 변환
    const searchTermLower = searchTerm.toLowerCase();

    // 모든 books를 가져와서 클라이언트 측에서 필터링
    // 실제 프로덕션에서는 Algolia 등 전문 검색 서비스를 사용하는 것이 좋습니다
    const snapshot = await booksRef.get();

    const results = [];

    snapshot.forEach((doc) => {
      const data = doc.data();
      const title = (data.title || "").toLowerCase();
      const author = (data.author || "").toLowerCase();

      // title 또는 author에 검색어가 포함되어 있는지 확인
      if (title.includes(searchTermLower) || author.includes(searchTermLower)) {
        // publishedDate와 createdAt을 적절한 형식으로 변환
        const formattedData = {...data};

        // publishedDate 포맷팅
        if (data.publishedDate) {
          // Firestore Timestamp를 ISO 8601 문자열로 변환
          if (data.publishedDate.toDate) {
            const date = data.publishedDate.toDate();
            formattedData.publishedDate = date.toISOString();
          } else if (typeof data.publishedDate === "string") {
            // 이미 문자열인 경우 Date 객체로 변환 후 ISO 형식으로
            try {
              const date = new Date(data.publishedDate);
              formattedData.publishedDate = date.toISOString();
            } catch (e) {
              // 변환 실패 시 원본 유지
              formattedData.publishedDate = data.publishedDate;
            }
          }
        }

        // createdAt 포맷팅
        if (data.createdAt) {
          // Firestore Timestamp를 ISO 8601 문자열로 변환
          if (data.createdAt.toDate) {
            const date = data.createdAt.toDate();
            formattedData.createdAt = date.toISOString();
          } else if (typeof data.createdAt === "string") {
            // 이미 문자열인 경우 Date 객체로 변환 후 ISO 형식으로
            try {
              const date = new Date(data.createdAt);
              formattedData.createdAt = date.toISOString();
            } catch (e) {
              // 변환 실패 시 원본 유지
              formattedData.createdAt = data.createdAt;
            }
          }
        }

        results.push({
          id: doc.id,
          ...formattedData,
        });
      }
    });

    logger.info(`Found ${results.length} results for "${searchTerm}"`);

    response.json({
      query: searchTerm,
      results: results,
      count: results.length,
    });
  } catch (error) {
    logger.error("Search error:", error);
    response.status(500).json({
      error: "검색 중 오류가 발생했습니다.",
      message: error.message,
    });
  }
});

// TodoItem CRUD API

// GET /todos - 페이징된 TodoItem 조회
exports.getTodos = onRequest(async (request, response) => {
  try {
    // Enable CORS
    response.set("Access-Control-Allow-Origin", "*");
    response.set("Access-Control-Allow-Methods", "GET");
    response.set("Access-Control-Allow-Headers", "Content-Type");

    if (request.method === "OPTIONS") {
      response.status(204).send("");
      return;
    }

    if (request.method !== "GET") {
      response.status(405).send("Method Not Allowed");
      return;
    }

    // 페이징 파라미터 파싱
    const page = parseInt(request.query.page) || 1; // 기본값: 1페이지
    const limit = parseInt(request.query.limit) || 20; // 기본값: 20개
    const offset = (page - 1) * limit;

    // 페이징 파라미터 검증
    if (page < 1) {
      response.status(400).json({
        error: "페이지 번호는 1 이상이어야 합니다.",
      });
      return;
    }

    if (limit < 1 || limit > 100) {
      response.status(400).json({
        error: "limit은 1-100 사이의 값이어야 합니다.",
      });
      return;
    }

    const db = admin.firestore();
    const todosRef = db.collection("todos");

    // 전체 개수 조회 (페이징 정보용)
    const totalSnapshot = await todosRef.get();
    const totalCount = totalSnapshot.size;
    const totalPages = Math.ceil(totalCount / limit);

    // 페이징된 데이터 조회
    let query = todosRef.orderBy("createdAt", "desc");

    if (offset > 0) {
      query = query.offset(offset);
    }

    const snapshot = await query.limit(limit).get();

    const todos = [];
    snapshot.forEach((doc) => {
      const data = doc.data();
      const formattedData = {...data};

      // createdAt 포맷팅
      if (data.createdAt && data.createdAt.toDate) {
        formattedData.createdAt = data.createdAt.toDate().toISOString();
      }

      todos.push({
        id: doc.id,
        ...formattedData,
      });
    });

    logger.info(`Retrieved ${todos.length} todos for page ${page}`);

    response.json({
      todos: todos,
      pagination: {
        currentPage: page,
        limit: limit,
        totalCount: totalCount,
        totalPages: totalPages,
        hasNext: page < totalPages,
        hasPrevious: page > 1,
      },
    });
  } catch (error) {
    logger.error("Get todos error:", error);
    response.status(500).json({
      error: "Todo 조회 중 오류가 발생했습니다.",
      message: error.message,
    });
  }
});

// POST /todos - 새 TodoItem 생성
exports.createTodo = onRequest(async (request, response) => {
  try {
    // Enable CORS
    response.set("Access-Control-Allow-Origin", "*");
    response.set("Access-Control-Allow-Methods", "POST");
    response.set("Access-Control-Allow-Headers", "Content-Type");

    if (request.method === "OPTIONS") {
      response.status(204).send("");
      return;
    }

    if (request.method !== "POST") {
      response.status(405).send("Method Not Allowed");
      return;
    }

    const {title, completed} = request.body;

    if (!title || typeof title !== "string" || title.trim() === "") {
      response.status(400).json({
        error: "제목이 필요합니다.",
      });
      return;
    }

    const todoData = {
      title: title.trim(),
      completed: completed || false,
      createdAt: serverTimestamp(),
    };

    const db = admin.firestore();
    const docRef = await db.collection("todos").add(todoData);

    logger.info("Created todo with ID:", docRef.id);

    // 생성된 문서 다시 조회하여 timestamp가 포함된 데이터 반환
    const doc = await docRef.get();
    const data = doc.data();
    const formattedData = {...data};

    if (data.createdAt && data.createdAt.toDate) {
      formattedData.createdAt = data.createdAt.toDate().toISOString();
    }

    response.status(201).json({
      id: doc.id,
      ...formattedData,
    });
  } catch (error) {
    logger.error("Create todo error:", error);
    response.status(500).json({
      error: "Todo 생성 중 오류가 발생했습니다.",
      message: error.message,
    });
  }
});

// PUT /todos/{id} - TodoItem 업데이트
exports.updateTodo = onRequest(async (request, response) => {
  try {
    // Enable CORS
    response.set("Access-Control-Allow-Origin", "*");
    response.set("Access-Control-Allow-Methods", "PUT");
    response.set("Access-Control-Allow-Headers", "Content-Type");

    if (request.method === "OPTIONS") {
      response.status(204).send("");
      return;
    }

    if (request.method !== "PUT") {
      response.status(405).send("Method Not Allowed");
      return;
    }

    // URL에서 ID 추출 (예: /todos/abc123)
    const pathParts = request.path.split("/");
    const todoId = pathParts[pathParts.length - 1];

    if (!todoId) {
      response.status(400).json({
        error: "Todo ID가 필요합니다.",
      });
      return;
    }

    const {title, completed} = request.body;

    const updateData = {};
    if (title !== undefined) {
      if (typeof title !== "string" || title.trim() === "") {
        response.status(400).json({
          error: "유효한 제목이 필요합니다.",
        });
        return;
      }
      updateData.title = title.trim();
    }
    if (completed !== undefined) {
      updateData.completed = Boolean(completed);
    }

    if (Object.keys(updateData).length === 0) {
      response.status(400).json({
        error: "업데이트할 데이터가 없습니다.",
      });
      return;
    }

    const db = admin.firestore();
    const docRef = db.collection("todos").doc(todoId);

    // 문서 존재 확인
    const doc = await docRef.get();
    if (!doc.exists) {
      response.status(404).json({
        error: "해당 Todo를 찾을 수 없습니다.",
      });
      return;
    }

    await docRef.update(updateData);

    logger.info("Updated todo with ID:", todoId);

    // 업데이트된 문서 다시 조회
    const updatedDoc = await docRef.get();
    const data = updatedDoc.data();
    const formattedData = {...data};

    if (data.createdAt && data.createdAt.toDate) {
      formattedData.createdAt = data.createdAt.toDate().toISOString();
    }

    response.json({
      id: updatedDoc.id,
      ...formattedData,
    });
  } catch (error) {
    logger.error("Update todo error:", error);
    response.status(500).json({
      error: "Todo 업데이트 중 오류가 발생했습니다.",
      message: error.message,
    });
  }
});

// DELETE /todos/{id} - TodoItem 삭제
exports.deleteTodo = onRequest(async (request, response) => {
  try {
    // Enable CORS
    response.set("Access-Control-Allow-Origin", "*");
    response.set("Access-Control-Allow-Methods", "DELETE");
    response.set("Access-Control-Allow-Headers", "Content-Type");

    if (request.method === "OPTIONS") {
      response.status(204).send("");
      return;
    }

    if (request.method !== "DELETE") {
      response.status(405).send("Method Not Allowed");
      return;
    }

    // URL에서 ID 추출 (예: /todos/abc123)
    const pathParts = request.path.split("/");
    const todoId = pathParts[pathParts.length - 1];

    if (!todoId) {
      response.status(400).json({
        error: "Todo ID가 필요합니다.",
      });
      return;
    }

    const db = admin.firestore();
    const docRef = db.collection("todos").doc(todoId);

    // 문서 존재 확인
    const doc = await docRef.get();
    if (!doc.exists) {
      response.status(404).json({
        error: "해당 Todo를 찾을 수 없습니다.",
      });
      return;
    }

    await docRef.delete();

    logger.info("Deleted todo with ID:", todoId);

    response.json({
      message: "Todo가 성공적으로 삭제되었습니다.",
      id: todoId,
    });
  } catch (error) {
    logger.error("Delete todo error:", error);
    response.status(500).json({
      error: "Todo 삭제 중 오류가 발생했습니다.",
      message: error.message,
    });
  }
});

// GET /todos/{id} - 특정 TodoItem 조회
exports.getTodo = onRequest(async (request, response) => {
  try {
    // Enable CORS
    response.set("Access-Control-Allow-Origin", "*");
    response.set("Access-Control-Allow-Methods", "GET");
    response.set("Access-Control-Allow-Headers", "Content-Type");

    if (request.method === "OPTIONS") {
      response.status(204).send("");
      return;
    }

    if (request.method !== "GET") {
      response.status(405).send("Method Not Allowed");
      return;
    }

    // URL에서 ID 추출 (예: /todos/abc123)
    const pathParts = request.path.split("/");
    const todoId = pathParts[pathParts.length - 1];

    if (!todoId) {
      response.status(400).json({
        error: "Todo ID가 필요합니다.",
      });
      return;
    }

    const db = admin.firestore();
    const doc = await db.collection("todos").doc(todoId).get();

    if (!doc.exists) {
      response.status(404).json({
        error: "해당 Todo를 찾을 수 없습니다.",
      });
      return;
    }

    const data = doc.data();
    const formattedData = {...data};

    if (data.createdAt && data.createdAt.toDate) {
      formattedData.createdAt = data.createdAt.toDate().toISOString();
    }

    logger.info("Retrieved todo with ID:", todoId);

    response.json({
      id: doc.id,
      ...formattedData,
    });
  } catch (error) {
    logger.error("Get todo error:", error);
    response.status(500).json({
      error: "Todo 조회 중 오류가 발생했습니다.",
      message: error.message,
    });
  }
});

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
