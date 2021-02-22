// need to load  jQuery and bootstrap3
// default shiny has both, only library shiny is enough


// js for clearableTextInput
clearText = function(clear_input_id){
  var textInput = document.getElementById(clear_input_id);
  var clearBtn = textInput.nextElementSibling;
  var textInputBox = textInput.parentElement;
  textInput.onkeyup = function(){
    clearBtn.style.visibility = (this.value.length) ? "visible" : "hidden";
  };
  clearBtn.onclick = function(){
    this.style.visibility = "hidden";
    textInput.value = "";
    Shiny.setInputValue(clear_input_id, "");
  };
  textInput.addEventListener("focus", () =>{
    textInputBox.classList.add("text-input-focused");
  }, false);
  textInput.addEventListener("blur", () =>{
    textInputBox.classList.remove("text-input-focused");
  }, false);
};


// general height matcher
function heightMatcher(div1, div2){
    return $(function(){
      var rb = new ResizeObserver(entries => {
        $(div1).height(entries[0].contentRect.height);
      });
      rb.observe($(div2).get(0));
    });
}

