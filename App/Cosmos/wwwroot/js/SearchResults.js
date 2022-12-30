document.getElementById("indirectText").style.color = "gray";

function showDirect() {
    document.getElementById("indirect").style.display = "none";
    document.getElementById("direct").style.display = "block";
    document.getElementById("indirectText").style.color = "gray";
    document.getElementById("directText").style.color = "white";
}
function showIndirect() {
    document.getElementById("direct").style.display = "none";
    document.getElementById("indirect").style.display = "block";
    document.getElementById("indirectText").style.color = "white";
    document.getElementById("directText").style.color = "gray";

}
