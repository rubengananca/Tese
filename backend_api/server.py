from flask import Flask
from app.routes import api_routes

app = Flask(__name__)

# Registar as rotas da API
app.register_blueprint(api_routes)

if __name__ == "__main__":
    app.run(debug=True)  # Executa o servidor localmente
