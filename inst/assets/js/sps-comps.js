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



// gallery
$(function(){
  $('.sps-gallery .inline-enlarge img').on('click', function(){
    var container = $(this).parent();
    if (container.hasClass('gallery-enlarge')) {
      container.removeClass('gallery-enlarge');
    } else {
      container.addClass('gallery-enlarge');
    }
  });
  var modalImg = $("#sps-gallery-modal-content")
  modalImg.click(e=>{
    e.stopPropagation();
  });
});

function fixGalHeight(galleryID){
    return $(function(){
      var galImg = $(`#${galleryID} img.img-gallery`);
      var galH4 = $(`#${galleryID} .sps-tab-link p.text-center.h4`);
      var rbImg = new ResizeObserver(entries => {
        var h4Heights = galH4.map(function(){
           return $(this).height();
        });
        var maxH = Math.max.apply(null, h4Heights);
        galImg.map(function(){
            $(this).height(1.2 * this.width);
            $(this).parent().height(1.2 * this.width + maxH + 20);
        });
      });
      rbImg.observe($(`#${galleryID}`).get(0));
    });
}


function galEnlarge(imgID){
  var bg = $("#sps-gallery-modal"),
      img = $("#sps-gallery-modal-content"),
      cap = $("#sps-gallery-modal .gallery-caption")
  bg.css("display", 'block');
  img.prop('src', $(`${imgID} img`).prop('src'));
  cap.text($(`${imgID} a`).text());
  setTimeout(function() {
    bg.addClass("modal-in");
  }, 10);
}

function galModalClose(){
  $("#sps-gallery-modal").removeClass("modal-in");
  setTimeout(function() {
    $("#sps-gallery-modal").css("display", 'none');
  }, 250);
}
