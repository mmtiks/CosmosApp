//SWAP
function swap() {
    var field1 = document.getElementById("origin")
    var field2 = document.getElementById("destination")
    let hold = field1.value
    field1.value = field2.value
    field2.value = hold
}

//SEARCH
function dropdown(input, places) {
    input.onfocus = function () {

        console.log(document.getElementById("datePicker").value)
        console.log(typeof (document.getElementById("datePicker").value))


        places.style.display = 'block';
        input.style.borderRadius = "5px 5px 0 0";
        var text = input.value.toUpperCase();
        for (let option of places.options) {
            if (option.value.toUpperCase().indexOf(text) > -1) {
                option.style.display = "block";
            } else {
                option.style.display = "none";
            }
        };
    };

    input.addEventListener('blur', (event) => {
        // registers option clicked before discarding it
        sleep(100).then(() => {
            places.style.display = 'none';
        });
    })
    for (let option of places.options) {
        option.onclick = function () {
            input.value = option.value;
            places.style.display = 'none';
            input.style.borderRadius = "5px";
        }
    };

    input.oninput = function () {
        var text = input.value.toUpperCase();
        for (let option of places.options) {
            if (option.value.toUpperCase().indexOf(text) > -1) {
                option.style.display = "block";
            } else {
                option.style.display = "none";
            }
        };
    }

    var currentFocus = -1;
    input.onkeydown = function (e) {
        if (e.keyCode == 40) {
            currentFocus++
            addActive(places.options);
        }
        else if (e.keyCode == 38) {
            currentFocus--
            addActive(places.options);
        }
        else if (e.keyCode == 13) {
            e.preventDefault();
            if (currentFocus > -1) {
                if (places.options)
                    places.options[currentFocus].click();
            }
        }
    }
}
function addActive(x) {
    if (!x) return false;
    removeActive(x);
    if (currentFocus >= x.length) currentFocus = 0;
    if (currentFocus < 0)
        currentFocus = (x.length - 1);
    x[currentFocus].classList.add("active");
    var currentFocus = -1;
}
function removeActive(x) {
    for (var i = 0; i < x.length; i++) {
        x[i].classList.remove("active")
    }
}

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}


dropdown(document.getElementById("origin"), document.getElementById("places"))
dropdown(document.getElementById("destination"), document.getElementById("places2"))
