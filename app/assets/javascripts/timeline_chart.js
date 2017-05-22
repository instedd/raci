function Projects(svg) {

	var self = this;
	var _svg, _container, _data, _sub, _width, _height, _xAxis, _yAxis, _totalPath, _subPath, _initialized,
		_margin = {top: 5, right: 5, bottom: 30, left: 5},
		_x = d3.scaleTime(),
		_y = d3.scaleLinear(),
		_line = d3.line()
		    .x(function(d) { return _x(d[0]); })
		    .y(function(d) { return _y(d[1]); })
		    .curve(d3.curveBasis);

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

	  	_svg.attr("width", _width + _margin.left + _margin.right)
	    		.attr("height", _height + _margin.top + _margin.bottom);
	  	_container.attr("transform", "translate(" + _margin.left + "," + _margin.top + ")");
	  	_xAxis.call(d3.axisBottom().scale(_x).ticks(d3.timeMonth.every(3)))
	  		.attr("transform", "translate(0," + _height + ")");
		_xAxis.selectAll(".tick text").style("font-size", 14).style("fill", "#666666").style("font-family", "Roboto").style("text-anchor", "start");
	  	_yAxis.call(d3.axisRight().scale(_y).ticks(5).tickSizeInner(_width).tickPadding(-_width));
		_yAxis.selectAll(".tick text").attr("dy", 20).style("font-size", 14).style("fill", "#666666").style("font-family", "Roboto");
		_yAxis.selectAll(".tick line").style("opacity", 0.1);
	  	_totalPath.datum(_data)
	  		.transition()
	  		.duration(_initialized? 500 : 0)
			.attr("d", _line)
			.style("stroke", _sub? "#cccccc" : _color);
		_subPath.datum(_sub? _sub : flat(_data))
	  		.transition()
	  		.duration(_initialized? 500 : 0)
			.attr("d", _line)
			.style("stroke", _color)
			.style("opacity", _sub? 1 : 0);

		_initialized = true;
	  	/*_container.attr("transform", "translate(" + _margin.left + "," + _margin.top + ")");
	  	initialized



	  	_container.selectAll(".bar").select(".label")
			    .attr("dy", -6)
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
			    .style("fill", _sub? "#cccccc" : null)
			    .attr("width", function (d) { return _x(d);})

		_container.selectAll(".bar").select(".sub")
			    .attr("x", reserved + MARGIN)
			    .attr("y", function (d, i) { return i * (BAND + MARGIN);})
			    .attr("height", BAND)
			    .transition()
			    .duration(_initialized? 500:0)
			    .attr("width", function(d, i) { return _sub? _x(_sub[i]) : 0; });

		_container.selectAll(".bar").select(".value")
				.text(function (d, i) { return _sub? _sub[i] : d;})
			    .attr("y", function (d, i) { return i * (BAND + MARGIN) + BAND;})
			    .attr("dx", 6)
			    .attr("dy", -6)
			    .transition()
			    .duration(_initialized? 500:0)
			    .attr("x", function(d) { return reserved + MARGIN + _x(d); });

		_svg.attr("width", _width + _margin.left + _margin.right)
	    		.attr("height", _data.length * (BAND + MARGIN) + _margin.top + _margin.bottom);*/
	}

	self.data = function(value) {
		if(arguments.length) {
			_data = value;
			_x.domain(d3.extent(_data, function(d) { return d[0]; }));
			_y.domain([0, d3.max(_data, function(d) { return d[1]; })]);
		} else {
			return _data;
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
	    _height = height - _margin.top - _margin.bottom;
	    _x.range([0, _width]);
		_y.range([_height, 0]);
	}

	function flat(source) {
		var data = [];
		for (var i = 0; i < source.length; i++) {
	      data.push([source[i][0], 0]);
	    }
	    return data;
	}

	function init(svg) {
		_svg = d3.select(svg);
		_container = _svg.append("g");
		_xAxis = _container.append("g")
      		.attr("class", "x axis");
      	_yAxis = _container.append("g")
      		.attr("class", "y axis");
		_totalPath = _container.append("path")
		  .attr("class", "line");
		_subPath = _container.append("path")
		  .attr("class", "line");
		self.setSize(960, 480);
	};

	init(svg);
}
