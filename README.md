### Condiciones del TP 6
#### Práctica:
Durante esta práctica pondremos a prueba nuestras habilidades con contenedores y Docker.  
El objetivo de esta práctica es crear una imagen de Docker y subirla a DockerHub para que cualquier persona la pueda descargar y utilizar.  
La complejidad de esta imagen será a elección del alumno (a mayor complejidad, mayor nota).   
Aunque tendrá que tener un mínimo de dificultad, para esto, la imagen tendrá que tener:  
- Algún archivo que sea agregado de forma externa con la opción de utilizar un volumen para almacenarlo  
- Algún servicio que se pueda acceder de forma remota (como puede ser una base de datos, un servicio web, etc)  
- Se tendrá que poder acceder desde la máquina Host donde se ejecute ese contenedor  
- El tag que utilice la imagen tendrá que seguir algún esquema de versionado y no el tag latest.  

#### Entregable:
El entregable de esta práctica será el dockerfile junto al link de DockerHub con la imagen subida para poder utilizarla.   
Así mismo, cualquier otro tipo de archivo secundario para la correcta construcción de la imagen será necesario que lo suban.  

#### Consejos:
Para la entrega de este Dockerfile se puede utilizar alguna imagen ya creada con algunas configuraciones hechas por ustedes (por ejemplo, usar como base alguna imagen un poco más pulida en vez de ubuntu, debian, centos, alpine, etc).  
O sino, pueden partir de una imagen de base como sistema operativo (ubuntu o alpine por ejemplo) y ahí instalar todo lo que necesite para su aplicación.   
También pueden utilizar una aplicación funcional desarrollada por ustedes o por un tercero y dockerizarla.  


#### Archivo necesario
appssettings.json  
´´´json
{
  //"Status": "Enabled",
  "Status": "Disabled",
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  },
  "AllowedHosts": "*"
}
´´´

#### Build
docker build  --rm -f Dockerfile -t tp6:version .

#### Run
docker run --rm -p 5273:80 -v /rutalocal/TodoApi/appsettings.json:/app/appsettings.json tp6:version

#### Request
curl -X 'GET' 'http://localhost:5273/api/TodoItems'
curl -X 'GET' 'http://localhost:5273/weatherforecast'