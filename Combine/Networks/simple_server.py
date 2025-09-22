from http.server import BaseHTTPRequestHandler, HTTPServer
import json
from urllib.parse import parse_qs, urlparse

unavailable_usernames = ['peterfriese', 'johnnyappleseed', 'page', 'johndoe', 'jmbae']

class UserNameHandler(BaseHTTPRequestHandler):
  def do_GET(self):
    parsed_url = urlparse(self.path)        
    if parsed_url.path == '/isUserNameAvailable':
      query_params = parse_qs(parsed_url.query)
      
      if 'userName' in query_params:
        username = query_params['userName'][0]
        print(f"사용자 이름 확인 요청: {username}")
        
        is_available = username not in unavailable_usernames
        
        response = {
            "isAvailable": is_available,
            "userName": username
        }
        
        self.send_response(200)
        self.send_header('Content-Type', 'application/json')
        self.send_header('Access-Control-Allow-Origin', '*')
        self.end_headers()
        
        self.wfile.write(json.dumps(response).encode())
        return
    
    self.send_response(404)
    self.end_headers()
    self.wfile.write(b'Not Found')


def run_server(port=8080):
    server_address = ('127.0.0.1', port)
    httpd = HTTPServer(server_address, UserNameHandler)
    print(f"서버 시작: http://127.0.0.1:{port}")
    print("사용 가능한 엔드포인트:")
    print(f"  GET /isUserNameAvailable?userName=<username>")
    print("\n서버를 중지하려면 Ctrl+C를 누르세요.")
    
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\n서버가 종료됩니다.")
        httpd.server_close()

if __name__ == "__main__":
    run_server()