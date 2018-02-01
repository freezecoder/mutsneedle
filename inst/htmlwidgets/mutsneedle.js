
create_download_link = function() {
  var s = document.getElementsByTagName('svg')[0];
  var x = new XMLSerializer();
  var b64 = btoa(x.serializeToString(s));
  var a = document.createElement('a');
  a.appendChild(document.createTextNode("Download SVG"));
  a.download = 'mutations-needle-plot.svg';
  a.href = 'data:image/svg+xml;base64,\n'+b64;
  a.hreflang = 'image/svg+xml';
  document.getElementsByTagName('body')[0].appendChild(a);
};

HTMLWidgets.widget({

  name: 'mutsneedle',

  type: 'output',

  factory: function(el, width, height) {
     var initialized = false;
    // TODO: define shared variables for this instance

    return {

      renderValue: function(opts) {
        // TODO: code to render the widget, e.g.

        var mutdata=testmutdata;

        if ( opts.mutdata ) {
            mutdata=opts.mutdata;
        } else {
            console.log("Warning. No valid mutation data present from mutsneedle, therefore using test data");
            alert("No Mutdata given, using test data")  ;
        }

        el.innerText = opts.message; // renders message inline

        //console.log(mutdata);
        console.log(el);
        //Set color map
        var colorMap= testColorMap;
        if (opts.colorMap){
          colorMap=opts.colorMap;
        }

	var xlab=" ";
	var ylab="Number of Mutations";
	if (opts.xlab) {
		xlab=opts.xlab;
	}
	if (opts.ylab){
		ylab=opts.ylab;
	}

        var legends = {
                  x:  opts.gene + ":" +opts.transcript + " " + opts.xlab ,
                  y:  opts.ylab
                };

        plotConfig = {
                maxCoord :      opts.max,
                minCoord :      0,
                targetElement : el,
                mutationData:   mutdata ,
                colorMap: colorMap,
                legends:        legends,
                width: width,
                height: height,
                responsive: 'resize'
           };

        if (opts.domains) {
          plotConfig.regionData=opts.domains;
        }

        MutsNeedlePlot = require("muts-needle-plot");
        p = new MutsNeedlePlot(plotConfig);

        if (!initialized) {
        initialized = true;
        // Code to set up event listeners and anything else that needs to run just once
              create_download_link();
      }


      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
