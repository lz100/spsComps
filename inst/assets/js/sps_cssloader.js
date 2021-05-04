
// get loader div
function chooseLoader(id, type, color, width, height){
  var types = {
    //
    "circle"   :
      `
      <div class="lds-circle">
        <div></div>
      </div>
      <style>
      #${id} .lds-circle > div {
        background: ${color};
      }
      </style>
      `,
    "dual-ring":
      `
      <div class="lds-dual-ring"></div>
      <style>
      #${id} .lds-dual-ring:after {
        border: calc(${height} *6/80) solid ${color};
        border-color: ${color} transparent ${color} transparent;
      }
      </style>
      `,
    //
    "facebook" :
      `
      <div class="lds-facebook">
        <div></div>
        <div></div>
        <div></div>
      </div>
      <style>
        #${id} .lds-facebook div {
          background: ${color};
          width: calc(${width} / 11 * 3 );
          animation: ${id}-lds-facebook 1.2s cubic-bezier(0, 0.5, 0.5, 1) infinite;
        }
        #${id} .lds-facebook div:nth-child(1) {
          left: 0px;
          animation-delay: -0.24s;
        }
        #${id} .lds-facebook div:nth-child(2) {
          left: calc(${width} / 11 * 4 );
          animation-delay: -0.12s;
        }
        #${id} .lds-facebook div:nth-child(3) {
          left: calc(${width} / 11 * 8 );
          animation-delay: 0;
        }
        @keyframes ${id}-lds-facebook {
          0% {
            top: 0;
            height: ${height};
          }
          50%, 100% {
            top: calc(${height} / 3);
            height: calc(${height} / 3);
          }
        }
      </style>
      `,
    //
    "heart"    :
      `
      <div class="lds-heart">
        <div></div>
      </div>
      <style>
      #${id} .lds-heart {
        width: calc(${width} / 2);
        height: calc(${height} / 2);
        top: calc(${height} / 1.414 / 2 );
        left: calc(${width} * 0.414 / 2 );
      }
      #${id} .lds-heart div {
        background: ${color};
      }
      #${id} .lds-heart div:after,
      #${id} .lds-heart div:before {
        background: ${color};
      }
       #${id} .lds-heart div:before {
        left: calc(-${width} / 3);
        border-radius: 50% 0 0 50%;
      }
       #${id} .lds-heart div:after {
        top: calc(-${height} / 3);
        border-radius: 50% 50% 0 0;
      }
      </style>
      `,
    //
    "ring"     :
      `
      <div class="lds-ring">
        <div></div>
        <div></div>
        <div></div>
        <div></div>
      </div>
      <style>
        #${id} .lds-ring div {
          border: calc(${height} / 5) solid green;
          border-color: ${color} transparent transparent transparent;
        }
      </style>
      `,
    //
    "roller"   :
      `
      <div class="lds-roller">
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
      </div>
      <style>
          #${id} .lds-roller div:after {
              background: ${color};
          }
          #${id} .lds-roller div {
            transform-origin: calc(${width}/2) calc(${height}/2);
          }
           #${id} .lds-roller div:after {
            content: " ";
            display: block;
            position: absolute;
            width: calc(${width}/8);
            height: calc(${height}/8);
          }
          #${id} .lds-roller div:nth-child(1):after {
            top: calc(${height}* 0.7875);
            left: calc(${width}* 0.7875);
          }
          #${id} .lds-roller div:nth-child(2):after {
            top: calc(${height}* 0.85);
            left: calc(${width}* 0.7);
          }
          #${id} .lds-roller div:nth-child(3):after {
            top: calc(${height}* 0.8875);
            left: calc(${width}* 0.6);
          }
          #${id} .lds-roller div:nth-child(4):after {
            top: calc(${height}* 0.9);
            left: calc(${width}* 0.5);
          }
          #${id} .lds-roller div:nth-child(5):after {
            top: calc(${height}* 0.8875);
            left: calc(${width}* 0.4);
          }
          #${id} .lds-roller div:nth-child(6):after {
            top: calc(${height}* 0.85);
            left: calc(${width}* 0.3);
          }
          #${id} .lds-roller div:nth-child(7):after {
            top: calc(${height}* 0.7875);
            left: calc(${width}* 0.2125);

          }
          #${id} .lds-roller div:nth-child(8):after {
            top: calc(${height}* 0.7);
            left: calc(${width}* 0.15);
          }
      </style>
      `,
    //
    "default"  :
      `
      <div class="lds-default">
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
      </div>
      <style>
      #${id} .lds-default div {
        background: ${color};
        width: calc(${width}/ 8);
        height: calc(${height}/ 8);
      }
      #${id} .lds-default div:nth-child(1) {
        top: calc(${height}* 0.4625);
        left: calc(${width}* 0.825);
      }
      #${id} .lds-default div:nth-child(2) {
        top: calc(${height}* 0.275);
        left: calc(${width}* 0.775);
      }
      #${id} .lds-default div:nth-child(3) {
        top: calc(${height}* 11/80);
        left: calc(${width}* 52/80);
      }
      #${id} .lds-default div:nth-child(4) {
        top: calc(${height}* 7/80);
        left: calc(${width}* 37/80);
      }
      #${id} .lds-default div:nth-child(5) {
        top: calc(${height}* 11/80);
        left: calc(${width}* 22/80);
      }
      #${id} .lds-default div:nth-child(6) {
        top: calc(${height}* 22/80);
        left: calc(${width}* 11/80);
      }
      #${id} .lds-default div:nth-child(7) {
        top: calc(${height}* 37/80);
        left: calc(${width}* 7/80);
      }
      #${id} .lds-default div:nth-child(8) {
        top: calc(${height}* 52/80);
        left: calc(${width}* 11/80);
      }
      #${id} .lds-default div:nth-child(9) {
        top: calc(${height}* 62/80);
        left: calc(${width}* 22/80);
      }
      #${id} .lds-default div:nth-child(10) {
        top: calc(${height}* 66/80);
        left: calc(${width}* 37/80);
      }
      #${id} .lds-default div:nth-child(11) {
        top: calc(${height}* 62/80);
        left: calc(${width}* 52/80);
      }
      #${id} .lds-default div:nth-child(12) {
        top: calc(${height}* 52/80);
        left: calc(${width}* 62/80);
      }
      </style>
      `,
    //
    "ellipsis" :
      `
      <div class="lds-ellipsis">
        <div></div>
        <div></div>
        <div></div>
        <div></div>
      </div>
      <style>
        #${id} .lds-ellipsis div {
            background: ${color};
            top: calc(${height}/ 3 + ${height}/ 8);
            width: calc(${width} /8);
            height: calc(${height}/ 8);
        }
        #${id} .lds-ellipsis div:nth-child(1) {
          left: calc(${width} /10);
        }
        #${id} .lds-ellipsis div:nth-child(2) {
          animation: ${id}-lds-ellipsis2 0.6s infinite;
          left: calc(${width} /10);
        }
        #${id} .lds-ellipsis div:nth-child(3) {
          animation: ${id}-lds-ellipsis2 0.6s infinite;
          left: calc(${width} *32/80);
        }
        #${id} .lds-ellipsis div:nth-child(4) {
          left: calc(${width} *56/80);
        }
        @keyframes ${id}-lds-ellipsis2 {
          0% {
            transform: translate(0, 0);
          }
          100% {
            transform: translate(calc(${width} *24/80), 0);
          }
        }
      </style>
      `,
    //
    "grid"     :
      `
      <div class="lds-grid">
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
      </div>
      <style>
        #${id} .lds-grid div {
          width: calc(${width} *16/80);
          height: calc(${height} *16/80);
          background: ${color};
        }
        #${id} .lds-grid div:nth-child(1) {
          top: calc(${height} *8/80);
          left: calc(${width} *8/80);
        }
        #${id} .lds-grid div:nth-child(2) {
          top: calc(${height} *8/80);
          left: calc(${width} *32/80);
        }
        #${id} .lds-grid div:nth-child(3) {
          top: calc(${height} *8/80);
          left: calc(${width} *56/80);
        }
        #${id} .lds-grid div:nth-child(4) {
          top: calc(${height} *32/80);
          left: calc(${width} *8/80);
        }
        #${id} .lds-grid div:nth-child(5) {
          top: calc(${height} *32/80);
          left: calc(${width} *32/80);
        }
        #${id} .lds-grid div:nth-child(6) {
          top: calc(${height} *32/80);
          left: calc(${width} *56/80);
        }
        #${id} .lds-grid div:nth-child(7) {
          top: calc(${height} *56/80);
          left: calc(${width} *8/80);
        }
        #${id} .lds-grid div:nth-child(8) {
          top: calc(${height} *56/80);
          left: calc(${width} *32/80);
        }
        #${id} .lds-grid div:nth-child(9) {
          top: calc(${height} *56/80);
          left: calc(${width} *56/80);
        }
      </style>
      `,
    //
    "hourglass":
      `
      <div class="lds-hourglass"></div>
      <style>
        #${id} .lds-hourglass:after {
          border: calc(${height} *35/80) solid ${color};
          margin: calc((${height} - ${height} *35/80*2)/2);
          border-color: ${color} transparent ${color} transparent;
        }
      </style>
      `,
    //
    "ripple"   :
      `
      <div class="lds-ripple">
        <div></div>
        <div></div>
      </div>
       <style>
        #${id} .lds-ripple div {
          margin: calc((${height} - ${height} *72/80)/2);
          border: calc(${height} *4/80) solid ${color};
          animation: ${id}-lds-ripple 1s cubic-bezier(0, 0.2, 0.8, 1) infinite;
        }
        #${id} .lds-ripple div:nth-child(2) {
          animation-delay: -0.5s;
        }
        @keyframes ${id}-lds-ripple {
          0% {
            top: calc(${height} *36/80);
            left: calc(${width} *36/80);
            width: 0;
            height: 0;
            opacity: 1;
          }
          100% {
            top: 0px;
            left: 0px;
            width: calc(${height} *72/80);
            height: calc(${width} *72/80);
            opacity: 0;
          }
        }
      </style>
      `,
    //
    "spinner"  :
      `
      <div class="lds-spinner">
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
      </div>
       <style>
        #${id} .lds-spinner div {
          transform-origin: calc(${width} /2) calc(${height} /2);
        }
        #${id} .lds-spinner div:after {
            top: calc(${height} *3/80);
            left: calc(${width} *37/80);
            width: calc(${width} *6/80);
            height: calc(${height} *18/80);
            background: ${color};
        }
      </style>
      `
  }
  return types[type] || '<div>type not found</div>';
}


Shiny.addCustomMessageHandler('sps-add-loader', function(data) {
  // selector,id ,type ,height ,width ,method , bgColor,
  // color ,opacity ,block , center, footer, zIndex, alert
  //get element
  var el = data.method !== 'full_screen' ? $(data.selector) : $(document);
  if (el.length != 1) {
    if (data.alert) alert("Loader: Cannot find element or more than one match");
    throw new Error("Loader: Cannot find element or more than one match");
  }
  var el_height = el.height(); el_width = el.width();
  var el_short = el_height > el_width ? el_width : el_height;
  var loader_divider = el_short < 100 || (data.height && data.width)? 10 : 20;
  var loader_height = data.height ? data.height : `${(el_short - 5)/loader_divider}rem`;
  var loader_width = data.width ? data.width :`${(el_short - 5)/loader_divider}rem`;

  if (el_height <= 0 || el_width <= 0) {
    if (data.alert) alert("Loader: element does not have height or width");
    throw new Error("Loader: element does not have height or width");
  }

  switch (data.method) {
  case 'replace':
    loaderReplace(
      el, data.id,
      loader_height,
      loader_width,
      data.opacity,
      data.center,
      data.block,
      data.footer
    );
    break;
  case 'inline':
    loaderInline(
      el, data.id,
      loader_height,
      loader_width,
      data.opacity,
      data.center
    );
    break;
  case 'full_screen':
    loaderFullscreen(
      data.id, loader_width, loader_height,
      data.opacity, data.center, data.block,
      data.footer, data.zIndex, data.bgColor
    );
    break;
  }

  var loader = chooseLoader(
    data.id, data.type, data.color,
    loader_height,
    loader_width,
  );
  $(`#${data.id}`).prepend(loader);

});

function loaderReplace(el, id, loader_height, loader_width, opacity, center, block, footer) {
  var newEl = el.clone().empty();
  newEl.attr('id', `${id}-container`);
  newEl.attr('is-inline', el.css('display').includes('inline') ? true : false);
  newEl.css({display: 'none', opacity: opacity});
  if (block) newEl.attr('disabled','disabled');

  var newEl_height = el.attr("height") ? `${el.attr("height")}px` : el.css("height")
  var newEl_width = el.attr("width") ? `${el.attr("width")}px` : el.css("width")
  newEl.css({height: newEl_height, width: newEl_width})

  newEl.prepend(
    `
    <div id=${id} style="height: ${loader_height}; width: ${loader_width}; display: block; opacity: 1; margin: ${center? 'auto' : '0'};">
    <div id=${id}-footer>
    </div>
    `);
  el.after(newEl);
  if (footer) $(`#${id}-footer`).append($(footer).css('text-align', 'center'));
}


function loaderInline(el, id, loader_height, loader_width, opacity, center) {
  var newEl = $('<div></div>');
  newEl.attr('id', `${id}-container`);
  newEl.attr('is-inline', 'true');
  newEl.css({
    display: 'none',
    verticalAlign: `${center? 'middle' : 'initial'}`,
    opacity: opacity
  });

  newEl.prepend(
    `
    <div id=${id} style="height: ${loader_height}; width: ${loader_width}; display: inline; opacity: ${opacity}; margin: 0;">
    </div>
    `);
  el.prepend(newEl);
}

function loaderFullscreen(
  id, loader_width, loader_height,
  opacity, center, block, footer,
  zIndex, bgColor
  ) {
  var newEl = $('<div></div>');
  newEl.attr('id', `${id}-container`);
  newEl.attr('is-inline', 'false');
  newEl.css({display: 'none'});
  if (block) newEl.attr('disabled','disabled');
  newEl.css({
    height: '100vh',
    width: '100vw',
    zIndex: zIndex,
    backgroundColor: bgColor,
    opacity: opacity,
    position: 'fixed',
    top: 0
  })

  newEl.prepend(
    `
    <div id=${id} style="height: ${loader_height}; width: ${loader_width}; display: block; opacity: 1; margin: ${center? 'auto' : '0'};">
    <div id=${id}-footer>
    </div>
    `);

  $('body').append(newEl);
  if (footer) $(`#${id}-footer`).append($(footer).css('text-align', 'center'));

}

Shiny.addCustomMessageHandler('sps-toggle-loader', function(data) {
  //selector,id ,state, method, alert
  var el = $(data.selector);
  if (el.length != 1) {
    let msg = `Loader: Cannot find target '${data.selector}' or more than one match`
    if (data.alert) alert(msg);
    throw new Error(msg);
  }
  var loader = $(`#${data.id}`);
  console.log(loader)
  console.log(loader.length)

  if (loader.length != 1 && data.method != "full_screen") {
    let msg = `Loader: Cannot find loader '${data.id}' or more than one match`
    if (data.alert) alert(msg);
    throw new Error(msg);
  }

  if(data.state == "show") {
    switch(data.method) {
      case "replace":
        el.hide();
      break;
      case "inline":
        if (data.block) {
          el.attr('disabled','disabled')
            .find("input, button, textarea, select, a[download]")
            .attr('disabled','disabled');
        };
      break;
      case "full_screen":
      break;
    }
    loader.css('display', loader.attr('is-inline') == "true" ? 'inline-flex' : 'flex');
  }
  if(data.state == "hide") {
    loader.hide();
    switch(data.method) {
      case "replace":
        el.show();
      break;
      case "inline":
        el.removeAttr('disabled')
          .find("input, button, textarea, select, a[download]")
          .removeAttr('disabled');
      break;
      case "full_screen":
      break;
    }
  }
})


