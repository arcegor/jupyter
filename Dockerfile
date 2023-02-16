FROM jupyterhub/jupyterhub

RUN python3 -m pip install --upgrade pip notebook

EXPOSE 8080

CMD ["jupyterhub"]

