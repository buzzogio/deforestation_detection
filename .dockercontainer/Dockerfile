# ---- Base image with Jupyter & Python 3.11 ----
FROM jupyter/base-notebook:python-3.11

# ---- Copy dependency list & install ----
WORKDIR /home/jovyan/work
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ---- Jupyter listens here ----
EXPOSE 8888

# ---- Start notebook (no token / password) ----
CMD ["start-notebook.sh", "--NotebookApp.token=''", "--NotebookApp.password=''"]
