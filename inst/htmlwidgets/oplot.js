HTMLWidgets.widget({

  name: 'oplot',

  type: 'output',

  factory: function(el, width, height) {

    const instance = { plot: null }

    return {

      // attach instance so available with HTMLWidget.findWidget return
      instance: instance,

      renderValue: function(x) {

        // for now crudely delete everything inside of widget container
        el.innerHTML = ""

        let plot = eval(x)
        // thought we could do something with plot object but appears to be dom element

        el.append(plot)

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
