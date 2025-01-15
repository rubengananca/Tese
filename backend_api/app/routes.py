from flask import Blueprint, jsonify, request

# Definir um "blueprint" para as rotas do API
api_routes = Blueprint('api_routes', __name__)

# Rota de registo
@api_routes.route('/register', methods=['POST'])
def register_user():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    # Validacao e resposta simples - mudar depois
    if username and password: 
        return jsonify({"success":True, "message":"User registered successfully"})
    else:
        return jsonify({"success":False, "message":"Invalid data"})
    
# Rota de login
@api_routes.route('/login', methods=['POST'])
def login_user():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    # Simulacao de login e autenticacao (substituir depois)
    if username == "admin" and password == "1234":
        return jsonify({"success":True, "message":"User logged in successfully"})
    else:
        return jsonify({"success":False, "message":"Invalid credentials"})
