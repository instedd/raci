function Map(svg, callbackIn, callbackOut) {

  var self = this;
  var _svg, _country, _data, _color, _width, _height, _initialized, _callbackIn, _callbackOut, _references, _gradient,
    _colorScale = d3.scaleLinear().domain([0, 1]).range(["#cccccc", "#000000"]);

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

    _data.forEach(function (d) {
      _svg.select("#" + d.key)
        .transition()
        .duration(_initialized? 500:0)
        .style("fill", _colorScale(d.value))
        .style("stroke", _colorScale(d.value))
        .style("opacity", 1);
    })

    _svg.attr("width", _width)
        .attr("height", _height);

    _country.attr("transform", "scale(" + Math.min(_width / _country.attr("width"), _height / _country.attr("height")) + ")")

    _references.attr("transform", "translate(" + (_width / 2 - 20) + "," + _height + ")");

    _references.select("rect")
      .attr("width", _width / 2)
      .attr("height", 12)
      .attr("y", -12);

    reference(_colorScale.domain()[1]);

    _initialized = true;
  }

  self.data = function(value) {
    if(arguments.length) {
      _data = value;
      max = Math.max(1, d3.max(_data, function(d) { return d.value; }));
      _colorScale.domain([0, max]);
    } else {
      return _data;
    }
  }

  self.color = function(value) {
    if(arguments.length) {
      _color = value;
      _colorScale.range(["#cccccc", _color])
      _gradient.select("#color")
        .attr("stop-color", _color);
    } else {
      return _color;
    }
  }

  self.setSize = function(width, height) {
    _width = width;
      _height = height;
  }

  function reference(value) {
    var offset = Math.max(1, _width / 2 * value / _colorScale.domain()[1] - 1);
    _references.select("text")
      .text(value)
      .attr("x", offset)
      .attr("fill", _colorScale(value));
    _references.select("line")
      .attr("x1", offset)
      .attr("x2", offset)
      .attr("stroke", _colorScale(value));
  }

  function init(svg, callbackIn, callbackOut) {
    _svg = d3.select(svg);
    _svg.selectAll("path")
      .on("mouseover", function(d, i) {
        var id = d3.select(this).attr("id");
        _callbackIn(id);
        reference(_data[i].value);
        _data.forEach(function (d) {
          _svg.select("#" + d.key)
            .transition()
            .style("fill", id == d.key? _colorScale(d.value) : "#cccccc")
            .style("stroke", id == d.key? _colorScale(d.value) : "#cccccc")
            .style("opacity", id == d.key? 1 : 0.5);
        })
      }).on("mouseout", function(d, i) {
        reference(_colorScale.domain()[1]);
        self.render();
        var id = d3.select(this).attr("id");
        _callbackOut(id);
      });
    _country = _svg.select("#ARG");
    _references = _svg.append("g").attr("id", "references");
    _references.append("rect");
    _references.append("line")
      .attr("y1","-14")
      .attr("y2","0");
    _references.append("text")
      .attr("y", -18);
    _callbackIn = callbackIn;
    _callbackOut = callbackOut;

    _gradient = _svg.append("defs")
              .append("linearGradient")
                      .attr("id", "gradient");

        _gradient.append("stop")
            .attr("stop-color", "#cccccc")
            .attr("offset", "0");

        _gradient.append("stop")
            .attr("id", "color")
            .attr("stop-color", "#000000")
            .attr("offset", "1");

    self.setSize(480, 480)
  };

  init(svg, callbackIn, callbackOut);
}
