<div id="bc" ></div>

<script id="script">
    var something = 10;
    //alert(something);
    var ddiv = document.getElementById("bc");
    var myDiv = ddiv.parentElement;
    var button = document.createElement("button");
    button.innerHTML = "Change color";
    button.onclick = function()
    {
        if(myDiv.style["background-color"] === "black")
            myDiv.style["background-color"] = "";
        else
            myDiv.style["background-color"] = "black";
    }
    myDiv.prepend(button);
    
    myDiv.removeChild(ddiv)
    myDiv.removeChild(document.getElementById("script"))
    
</script>

#Vesta
Unoffical, alternative neptun app

##Demo
![Vesta app demo](repository_assets/vesta_output.gif)