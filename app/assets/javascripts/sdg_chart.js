function ODS(svg, callbackIn, callbackOut) {

  var self = this;
  var MARGIN = 2;
  var _svg, _container, _data, _sub, _width, _height, _callbackOut, _callbackIn,
    _initialized = false,
    _margin = {top: 20, right: 0, bottom: 0, left: 0},
    _x = d3.scaleBand(),
    _y = d3.scaleLinear();

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

    var full = _x.bandwidth() > 36;

    _x.paddingInner(full? .2 : .4);
    _y.range([0, _height + (full? 0 : _x.bandwidth())]);

    _container.attr("transform", "translate(" + _margin.left + "," + _margin.top + ")");

    _container.selectAll(".bar").select(".area")
        .attr("x", function(d, i) { return _x(i); })
        .attr("width", _x.step())
        .style("fill", "transparent")
        .attr("y", 0)
        .attr("height", _height + MARGIN + _x.bandwidth());

    _container.selectAll(".bar").select(".background")
          .attr("x", function(d, i) { return _x(i); })
          .attr("y", function(d) { return _height + MARGIN; })
          .attr("width", _x.bandwidth())
          .attr("height", _x.bandwidth())
          .attr("display", full? "block" : "none")

    _container.selectAll(".bar").select("svg")
      .attr("width", _x.bandwidth())
      .attr("height", _x.bandwidth())
      .attr("x", function(d, i) { return _x(i);})
      .attr("y", _height + MARGIN)
      .attr("display", full? "block" : "none")

    _container.selectAll(".bar").select(".total")
          .attr("x", function(d, i) { return _x(i); })
          .attr("width", _x.bandwidth())
          .transition()
          .duration(_initialized? 500:0)
          .style("fill", _sub? "#cccccc" : null)
          .attr("y", function(d) { return _height - _y(d) + (full? 0 : _x.bandwidth()); })
          .attr("height", function(d) { return _y(d); });

    _container.selectAll(".bar").select(".sub")
          .attr("x", function(d, i) { return _x(i); })
          .attr("width", _x.bandwidth())
          .transition()
          .duration(_initialized? 500:0)
          .attr("y", function(d, i) { return (_sub? _height - _y(_sub[i]) : _height) + (full? 0 : _x.bandwidth()); })
          .attr("height", function(d, i) { return _sub? _y(_sub[i]) : 0; });

    _container.selectAll(".bar").select("text")
        .text(function (d, i) { return _sub? _sub[i] : d;})
        .attr("x", function(d, i) { return _x(i) + _x.bandwidth() / 2; })
        .attr("dy", -6)
        .transition()
        .duration(_initialized? 500:0)
        .attr("y", function(d) { return _height - _y(d) + (full? 0 : _x.bandwidth()); })
        .style("font-size", full? null : 10);

    _svg.attr("width", _width + _margin.left + _margin.right)
          .attr("height", _height + _margin.top + _margin.bottom + _x.bandwidth() + MARGIN);

     _initialized = true;
  }

  self.data = function(value) {
    if(arguments.length) {
      _data = value;

      _container.selectAll(".bar").data(_data)
        .enter()
        .append("g")
        .attr("class", function (d, i) { return "bar ods" + (i + 1);})
        .each(function(d, i) {
          d3.select(this).append("rect").attr("class" , "area");
          d3.select(this).append("rect").attr("class" , "background");
          d3.select(this).append("rect").attr("class" , "total");
          d3.select(this).append("rect").attr("class" , "sub");
          d3.select(this).append("text");
          d3.select(this).append("svg")
            .attr("class", "icon")
            .append("use")
            .attr("class", "menu-item")
            .attr("xlink:href", "#sym-ODS" + (i + 1))
        })
        .on("mouseover", function(d, i) {
          _container.selectAll(".bar")
            .transition()
            .style("fill", function (d, j) {return i == j? null : "#cccccc"});

          d3.select(this).select("use rect")
            .attr("fill", function (d, j) {return i == j? null : "#cccccc"});

          _callbackIn(i + 1);
        })
        .on("mouseout", function(d, i) {
          _container.selectAll(".bar")
            .transition()
            .style("fill", null);

          _callbackOut(i+1);
        });

      _x.domain(d3.range(_data.length));
      _y.domain([0, d3.max(_data, function(d) { return d; })]);
    } else {
      return _data;
    }
  }

  self.sub = function(value) {
    if(arguments.length) {
      if(value == null) _sub = undefined;
      else _sub = value;
    } else {
      return _sub;
    }
  }

  self.setSize = function(width, height) {
    _width = width - _margin.left - _margin.right;
    _x.rangeRound([0, _width]);
    _height = height - _margin.top - _margin.bottom - _x.bandwidth() - MARGIN;
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
