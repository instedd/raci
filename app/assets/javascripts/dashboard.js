$(document).on('turbolinks:load', function(){
  if($('#dashboard').length > 0) {
    var map;
    var COLORS = ["#e5243b", "#dda63a", "#4c9f38", "#c5192d", "#ff3a21", "#26bde2", "#fcc30b", "#a21942", "#fd6925", "#dd1367", "#fd9d24", "#bf8b2e", "#3f7e44", "#0a97d9", "#56c02b", "#00689d", "#19486a"];
    var PROVINCES = ["BA", "CABA", "CAT", "CBA", "CHO", "CHT", "COR", "ER", "FSA", "JUJ", "LP", "LR", "MIS", "MZA", "NEU", "RN", "SAL", "SC", "SE", "SF", "SJ", "SL", "TF", "TUC"];
    var sdg;
    var labels = ["Adolescentes", "Adultos mayores", "Discapacidades", "LGBTQ", "Mujer", "Niños", "Pueblos originarios", "SIDA", "Víctimas de abuso"];
    var groups;
    var timelineData = [[new Date("1-May-07"),  35],
          [new Date("1-Jun-07"),  40],
          [new Date("1-Jul-07"),  81],
          [new Date("1-Aug-07"),  392],
          [new Date("1-Oct-07"),  506],
          [new Date("1-Nov-07"),  688],
          [new Date("1-Dec-07"), 734],
          [new Date("1-Jan-08"), 874],
          [new Date("1-Feb-08"), 936],
          [new Date("1-Mar-08"), 752],
          [new Date("1-Apr-08"), 1234]];
    var projects;

    function callbackMap(id) {
      console.log("Province " + id);
    }

    function callbackSdg(id) {
      console.log("sdg " + id);
    }

    function callbackPopulation(id) {
      console.log("Group " + id);
    }

    function getSubSdg(source) {
      data = []
      for (var i = 0; i < source.length; i++) {
        data.push(Math.round(source[i] * Math.random()));
      }
      return data;
    }

    function getDataSdg() {
      var data = [];
      for (var i = 1; i <= 17; i++) {
        if(projects_by_sdg[i]) data.push(projects_by_sdg[i])
        else data.push(0)
      }
      return data;
    }

    function getDataMap() {
      var data = [];
      PROVINCES.forEach(function(d) {
        data.push({key: d, value:Math.round(Math.random() * 300)});
      })
      return data;
    }

    function getDataPopulation() {
      var data = [];
      for (var i = 0; i < labels.length; i++) {
        data.push(Math.round(Math.random() * 300))
      }
      return data;
    }

    function getSubPopulation(source) {
      data = []
      for (var i = 0; i < source.length; i++) {
        data.push(Math.round(source[i] * Math.random()));
      }
      return data;
    }

    function getSubTimeline(source) {
      data = []
      for (var i = 0; i < source.length; i++) {
        data.push([source[i][0], Math.round(source[i][1] * Math.random())]);
      }
      return data;
    }

    // map
    map = new Map(document.querySelector("#map svg"), callbackMap);
    map.data(getDataMap());
    map.color(COLORS[Math.round(Math.random() * (COLORS.length - 1))]);
    map.setSize(document.querySelector("#map").offsetWidth - 20, window.innerHeight * 0.5);
    map.render();

    // sdgs
    sdg = new ODS(document.querySelector("svg#sdg-chart"), callbackSdg);
    sdg.data(getDataSdg());
    sdg.setSize(window.innerWidth - 50, window.innerHeight * 0.5);
    sdg.render();

    // population
    groups = new Groups(document.querySelector("#population svg"), callbackPopulation);
    groups.labels(labels);
    groups.data(getDataPopulation());
    groups.color(COLORS[Math.round(Math.random() * (COLORS.length - 1))]);
    groups.setSize(document.querySelector("#population").offsetWidth - 20, window.innerHeight * 0.5);
    groups.render();

    // timeline
    projects = new Projects(document.querySelector("#timeline svg"));
    projects.data(timelineData);
    projects.color(COLORS[Math.round(Math.random() * (COLORS.length - 1))]);
    projects.setSize(document.querySelector("#timeline").offsetWidth - 20, window.innerHeight * 0.5);
    projects.render();

    window.addEventListener("resize", function (e) {
      // map
      map.setSize(document.querySelector("#map").offsetWidth - 20, window.innerHeight * 0.5);
      map.render();

      // sdgs
      sdg.setSize(window.innerWidth - 20, window.innerHeight - 20);
      sdg.render();

      // population
      groups.setSize(document.querySelector("#population").offsetWidth - 20, window.innerHeight * 0.5);
      groups.render();

      //timeline
      projects.setSize(document.querySelector("#timeline").offsetWidth - 20, window.innerHeight * 0.5);
      projects.render();
    });

    window.addEventListener("click", function (e) {
      // map
      map.data(getDataMap());
      map.color(COLORS[Math.round(Math.random() * (COLORS.length - 1))]);
      map.render();

      // sdgs
      sdg.sub(getSubSdg(sdg.data()));
      sdg.render();

      // population
      groups.sub(getSubPopulation(groups.data()));
      groups.color(COLORS[Math.round(Math.random() * (COLORS.length - 1))]);
      groups.render();

      // timeline
      projects.sub(Math.random() > .5? getSubTimeline(projects.data()) : null);
      projects.color(COLORS[Math.round(Math.random() * (COLORS.length - 1))]);
      projects.render();
    })
  }
})
