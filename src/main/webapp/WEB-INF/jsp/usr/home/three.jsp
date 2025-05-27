<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>three.js webgl - animation - keyframes</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/resource/main.css">
    <style>
        body {
            background-color: #bfe3dd;
            color: #000;
        }

        a {
            color: #2983ff;
        }
    </style>
</head>
<body>

<div id="container"></div>

<div id="info">
    <a href="https://threejs.org" target="_blank" rel="noopener">three.js</a> webgl - animation - keyframes<br/>
    Model: <a href="https://artstation.com/artwork/1AGwX" target="_blank" rel="noopener">Littlest Tokyo</a> by
    <a href="https://artstation.com/glenatron" target="_blank" rel="noopener">Glen Fox</a>, CC Attribution.
</div>

<script type="importmap">
    {
        "imports": {
            "three": "${pageContext.request.contextPath}/static/build/three.module.js",
            "three/addons/": "${pageContext.request.contextPath}/static/resource/jsm/"
        }
    }
</script>

<script type="module" src="${pageContext.request.contextPath}/static/resource/main.js"></script>

</body>
</html>