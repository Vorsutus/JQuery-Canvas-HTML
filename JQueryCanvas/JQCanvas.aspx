<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="JQCanvas.aspx.cs" Inherits="JQueryCanvas.JQCanvas" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>JQuery Canvas Project</title>

    <link href="https://fonts.googleapis.com/css?family=La+Belle+Aurore" rel="stylesheet" />

    <link href="Styles/Main.css" rel="stylesheet" />

    <%--internal stylesheet--%>
    <style type="text/css">
        canvas {
            border: 1px solid black;
            margin: 20px;
        }

        p {
            font-size: 1.6em;
        }
    </style>

    <%--java scripts reads in order from top down so java script should be at the bottom typically--%>
    <%--link to the jquery library--%>
    <script src="Scripts/jquery-3.4.1.js"></script>

    <%--jquery that is refering to javascript functions--%>
    <script type="text/javascript">
        //refer to the whole page with $(window)
        $(window).on("load", function () {
            //$ goes out and gets the DOM object and returns an array even if it's just one item
            var canvas1 = $(canvas_1)[0];
            var context1 = canvas1.getContext('2d');
            var canvas2 = $(canvas_2)[0];
            var context2 = canvas2.getContext('2d');

            //canvas Dimensions
            $("#CanvasHeight, #CanvasWidth").change(function () {
                var canvasY = $(CanvasHeight).val();
                var canvasX = $(CanvasWidth).val();

                $(canvas1).attr({
                    height: canvasY,
                    width: canvasX
                });
            });

            //Signiture
            $(canvas2).toggle();
            context2.clearRect(0, 0, canvas2.width, canvas2.height);
            context2.font = "30px 'La Belle Aurore'";
            context2.fillText("Chris Ross", 0, 30);
            $(sig).on("click", function () {
                $(canvas2).slideToggle("Slow");
            });

            //DrawShape
            $(Button).on("click", function () {
                var centerX = canvas1.width / 2;
                var centerY = canvas1.height / 2;

                var shape = $("input[name=shape]:checked").val();
                var color = $("input[name=color]:checked").val();

                context1.fillStyle = color;

                if (shape == "rectangle") {
                    var rectWidth = $(rect_Width).val();
                    var rectHeight = $(rect_Height).val();

                    var Xcord = centerX - (rectWidth / 2);
                    var Ycord = centerY - (rectHeight / 2);

                    //draw rect
                    context1.clearRect(0, 0, canvas1.width, canvas1.height);
                    context1.fillRect(Xcord, Ycord, rectWidth, rectHeight);
                }
                else if (shape == "circle") {
                    var radius = $(circle_radius).val();
                    context1.clearRect(0, 0, canvas1.width, canvas1.height);
                    context1.beginPath();
                    context1.arc(centerX, centerY, radius, 0, 2 * Math.PI, false);
                    context1.fill();
                    context1.stroke();
                    context1.closePath();
                }
                else {
                    var baseWidth = $(base_Width).val();
                    var triHeight = $(tri_Height).val();

                    context1.clearRect(0, 0, canvas1.width, canvas1.height);

                    context1.beginPath();
                    context1.moveTo(centerX - (baseWidth / 2), centerY + (triHeight / 2));
                    context1.lineTo(centerX + (baseWidth / 2), centerY + (triHeight / 2));
                    context1.lineTo(centerX, centerY - (triHeight / 2));
                    context1.fill();
                    context1.closePath();
                }
            });
        });
    </script>

</head>

<body>

    <%--all scripting is done here in browser itself and not on the server--%>
    <form id="form1" runat="server">

        <div id="form">
            <h1>Canvas JQuery App</h1>
            <p>
                <%--these are text boxes we can use with javascript--%>
                <label for="CanvasWidth">Canvas Width: </label>
                <%--input is used for any kind of interaction (textboxes, etc.) that the user will use--%>
                <%--"textbox type" with id from Canvaswidth with a textbox size of 5 and default value of 200--%>
                <input type="text" id="CanvasWidth" size="5" value="200" />
                <br />
                <label for="CanvasHeight">Canvas Height: </label>
                <input type="text" id="CanvasHeight" size="5" value="200" />
            </p>
            <br />
            <p>
                <%--Rectangle--%>
                <span style="text-decoration: underline">Shape: </span>
                <br />
                <label for="rectangle">Rectangle: </label>
                <input type="radio" id="rectangle" name="shape" value="rectangle" checked="checked" />
                <br />
                <label for="rect_Width">Width: </label>
                <input type="text" id="rect_Width" size="5" value="100" />

                <label for="rect_Height">Height: </label>
                <input type="text" id="rect_Height" size="5" value="100" />
                <br />
                <br />
                <%--Circle--%>
                <label for="circle">Circle: </label>
                <input type="radio" id="circle" name="shape" value="circle" />
                <br />
                <%--Radius--%>
                <label for="circle_radius">Radius: </label>
                <input type="text" id="circle_radius" size="5" value="50" />
                <br />
                <br />
                <%--Triangle--%>
                <label for="triangle">Triangle: </label>
                <input type="radio" id="triangle" name="shape" value="triangle" />
                <br />
                <label for="base_Width">Base Width: </label>
                <input type="text" id="base_Width" size="5" value="100" />

                <label for="tri_Height">Height: </label>
                <input type="text" id="tri_Height" size="5" value="100" />
            </p>
            <br />
            <p>
                <span style="text-decoration: underline">Color: </span>
                <br />
                <label for="black">Black: </label>
                <input type="radio" id="black" name="color" value="black" checked="checked" />
                <label for="blue">Blue: </label>
                <input type="radio" id="blue" name="color" value="blue" />
                <label for="red">Red: </label>
                <input type="radio" id="red" name="color" value="red" />
                <label for="green">Green: </label>
                <input type="radio" id="green" name="color" value="green" />
            </p>
            <br />
            <p style="text-align: center">
                <input type="button" class="button" id="Button" value="Draw Shape" />
            </p>
            <p>
                <input type="checkbox" id="sig" />
                <label for="sig">Signature</label>
            </p>
        </div>

    </form>

    <%-- Cavas Element (first and second)--%>
    <div style="float: left">
        <%--can grab the id value of canvas_1 to alter the canvas--%>
        <canvas id="canvas_1" height="200" width="200"></canvas>
        <canvas style="display: block; margin-top: -20px; border: none;" id="canvas_2" height="75" width="300"></canvas>
    </div>
    <div style="font-family:'La Belle Aurore';">.</div>

</body>

</html>
