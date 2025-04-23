from fastapi import FastAPI

app = FastAPI()

@app.get("/helloworld")
def hello():
    return {"message": "Hello World"}
