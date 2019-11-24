FROM python:3.7.5
WORKDIR /code
COPY . .
RUN pip install -e '.[test]'
ENV FLASK_APP=js_example
EXPOSE 5000
CMD ["flask", "run", "--host=0.0.0.0"]
