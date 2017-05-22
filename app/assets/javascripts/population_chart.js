function Groups(svg, callbackIn, callbackOut) {

  var self = this;
  var MARGIN = 18;
  var BAND = 18;
  var _svg, _container, _data, _sub, _width, _height, _labels, _color, _callbackIn, _callbackOut,
    _initialized = false,
    _margin = {top: 0, right: 40, bottom: 0, left: 0},
    _x = d3.scaleLinear();

  d3.formatDefaultLocale({"decimal": ",",
              "thousands": ".",
              "grouping": [3],
              "currency": ["$", ""]
              });

  d3.timeFormatDefaultLocale({"dateTime": "%a %b %e %X %Y",
                "date": "%d/%m/%Y",
                "time": "%H:%M:%S",
                "periods": ["AM", "PM"],
                "days": ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"],
                "shortDays": ["Dom", "Lun", "Mar", "Mi", "Jue", "Vie", "Sab"],
                "months": ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
                "shortMonths": ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]
              });


  self.render = function() {
      _container.attr("transform", "translate(" + _margin.left + "," + _margin.top + ")");

      _container.selectAll(".bar").select(".label")
          .attr("dy", -4)
          .attr("y", function (d, i) { return (BAND + MARGIN) * i + BAND;})
          .text(function (d, i) {return _labels[i];});

    var reserved = 0;

    _container.selectAll(".label").each(function (d) {
      reserved = Math.max(reserved, this.getBBox().width);
    })

    _x.range([0, _width - reserved - MARGIN]);

    _container.selectAll(".bar")
        .transition()
          .duration(_initialized? 500:0)
          .style("fill", _color)

    _container.selectAll(".bar").select(".area")
          .attr("y", function (d, i) { return i * (BAND + MARGIN);})
          .attr("width", _width)
          .attr("height", BAND + MARGIN)
          .style("fill", "transparent");

    _container.selectAll(".bar").select(".total")
          .attr("x", reserved + MARGIN)
          .attr("y", function (d, i) { return i * (BAND + MARGIN);})
          .attr("height", BAND)
          .transition()
          .duration(_initialized? 500:0)
          .style("fill", "#cccccc")
          .attr("width", function (d) { return _x(d);})

    _container.selectAll(".bar").select(".sub")
          .attr("x", reserved + MARGIN)
          .attr("y", function (d, i) { return i * (BAND + MARGIN);})
          .attr("height", BAND)
          .transition()
          .duration(_initialized? 500:0)
          .attr("width", function(d, i) { return _sub? _x(_sub[i]) : _x(d); });

    _container.selectAll(".bar").select(".value")
        .text(function (d, i) { return _sub? _sub[i] : d;})
          .attr("y", function (d, i) { return i * (BAND + MARGIN) + BAND;})
          .attr("dx", 6)
          .attr("dy", -6)
          .transition()
          .duration(_initialized? 500:0)
          .attr("x", function(d) { return reserved + MARGIN + _x(d); });

    _svg.attr("width", _width + _margin.left + _margin.right)
          .attr("height", _data.length * (BAND + MARGIN) + _margin.top + _margin.bottom);
     _initialized = true;
  }

  self.data = function(value) {
    if(arguments.length) {
      _data = value;

      _container.selectAll(".bar").data(_data)
        .enter()
        .append("g")
        .attr("class", "bar")
        .each(function(d, i) {
          d3.select(this).append("rect").attr("class" , "area");
          d3.select(this).append("rect").attr("class" , "total");
          d3.select(this).append("rect").attr("class" , "sub");
          d3.select(this).append("text").attr("class" , "label");
          d3.select(this).append("text").attr("class" , "value");
        })
        .on("mouseover", function(d, i) {
          _container.selectAll(".bar")
            .transition()
            .style("fill", function (d, j) {return i == j? _color : "#cccccc"});
          _callbackIn(_labels[i]);
        })
        .on("mouseout", function(d, i) {
          _container.selectAll(".bar")
            .transition()
            .style("fill", _color);
          _callbackOut(_labels[i]);
        });

      _x.domain([0, d3.max(_data, function(d) { return d; })]);

    } else {
      return _data;
    }
  }

  self.labels = function(value) {
    if(arguments.length) {
      _labels = value;
    } else {
      return _labels;
    }
  }

  self.color = function(value) {
    if(arguments.length) {
      _color = value;
    } else {
      return _color;
    }
  }

  self.sub = function(value) {
    if(arguments.length) {
      _sub = value;
    } else {
      return _sub;
    }
  }

  self.setSize = function(width, height) {
    _width = width - _margin.left - _margin.right;
  }

  function init(svg, callbackIn, callbackOut) {
    _svg = d3.select(svg);
    _container = _svg.append("g");
    _callbackIn = callbackIn;
    _callbackOut = callbackOut;
    self.setSize(960, 480)
  };

  init(svg, callbackIn, callbackOut);
}
