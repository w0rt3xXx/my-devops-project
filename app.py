from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def hello():
    # Это сообщение, которое будет отображаться в браузере
    return "Привет от DevOps проекта! Я работаю!!"

if __name__ == "__main__":
    # Приложение будет работать на порту 5000
    port = int(os.environ.get("PORT", 5000))
    # host='0.0.0.0' делает приложение доступным извне контейнера, что нам понадобится позже
    app.run(debug=True, host='0.0.0.0', port=port)