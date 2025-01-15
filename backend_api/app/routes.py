<<<<<<< HEAD
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
=======
from flask import Blueprint, request, jsonify

# Definir um "Blueprint" para agrupar rotas
api_routes = Blueprint("api_routes", __name__)

# Rota de registo
@api_routes.route("/register", methods=["POST"])
def register_user():
    data = request.json  # Dados enviados pelo Flutter
    username = data.get("username")
    password = data.get("password")
    
    # Simples validação e resposta (substituir por lógica de base de dados)
    if username and password:
        return jsonify({"success": True, "message": "Usuário registado com sucesso!"})
    else:
        return jsonify({"success": False, "message": "Dados inválidos!"})
    
# Rota de login
@api_routes.route("/login", methods=["POST"])
def login_user():
    data = request.json
    username = data.get("username")
    password = data.get("password")
    
    # Simulação de autenticação (substituir por lógica de autenticação real)
    if username == "admin" and password == "1234":
        return jsonify({"success": True, "message": "Login efetuado com sucesso!"})
    else:
        return jsonify({"success": False, "message": "Usuário ou senha inválidos!"})
>>>>>>> main
