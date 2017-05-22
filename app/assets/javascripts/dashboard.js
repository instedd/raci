$(document).on('turbolinks:load', function(){
  if($('#dashboard').length > 0) {
    var map;
    var COLORS = ["#e5243b", "#dda63a", "#4c9f38", "#c5192d", "#ff3a21", "#26bde2", "#fcc30b", "#a21942", "#fd6925", "#dd1367", "#fd9d24", "#bf8b2e", "#3f7e44", "#0a97d9", "#56c02b", "#00689d", "#19486a"];
    var defaultColor = "#1f4388";
    var PROVINCES = ["BA", "CABA", "CAT", "CBA", "CHO", "CHT", "COR", "ER", "FSA", "JUJ", "LP", "LR", "MIS", "MZA", "NEU", "RN", "SAL", "SC", "SE", "SF", "SJ", "SL", "TF", "TUC"];
    var sdg;
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

    function callbackSdg(id) {
      console.log('HOLA')
      // population
      // groups.sub(getDataPopulation(projects_by_population["by_sdg"][id]));
      // groups.color(COLORS[id-1]);
      // groups.render();

      // map
      map.data(getDataMap(projects_by_location["by_sdg"][id]));
      map.color(COLORS[id-1]);
      map.render();
    }

    function backToNormalSdg(id) {
      // groups.color(defaultColor);
      // groups.sub(null);
      // groups.render();

      map.data(getDataMap(projects_by_location["location_counts"]));
      map.color(defaultColor);
      map.render();
    }

    function callbackMap(id) {
      // sdgs
      sdg.sub(getDataSdg(projects_by_sdg["by_location"][id]));
      sdg.render();

      // population
      groups.sub(getDataPopulation(projects_by_population["by_location"][id]));
      groups.render();
    }

    function backToNormalMap(id) {
      // population
      groups.sub(null);
      groups.render();
      // sdgs
      sdg.sub(null);
      sdg.render();
    }

    function callbackPopulation(id) {
      // sdgs
      sdg.sub(getDataSdg(projects_by_sdg["by_population"][id]));
      sdg.render();

      // map
      map.data(getDataMap(projects_by_location["by_population"][id]));
      map.render();
    }

    function backToNormalPopulation(id) {
      map.data(getDataMap(projects_by_location["location_counts"]));
      map.color(defaultColor);
      map.render();

      sdg.sub(null);
      sdg.render();
    }

    function getDataSdg(original) {
      var data = [];
      for (var i = 1; i <= 17; i++) {
        if(original && original[i]) data.push(original[i])
        else data.push(0)
      }
      return data;
    }

    function getDataMap(original) {
      var data = [];
      PROVINCES.forEach(function(d) {
        if(original && original[d]) data.push({key: d, value: original[d] });
        else data.push({key: d, value: 0 });
      })
      return data;
    }

    function getDataPopulation(original) {
      var data = [];
      labels.forEach(function(label) {
        if(original && original[label]) data.push(original[label]);
        else data.push(0)
      })
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
    map = new Map(document.querySelector("#map svg"), callbackMap, backToNormalMap);
    map.data(getDataMap(projects_by_location["location_counts"]));
    map.color(defaultColor);
    map.setSize(document.querySelector("#map").offsetWidth - 20, window.innerHeight * 0.5);
    map.render();

    // sdgs
    sdg = new ODS(document.querySelector("svg#sdg-chart"), callbackSdg, backToNormalSdg);
    sdg.data(getDataSdg(projects_by_sdg["sdg_counts"]));
    sdg.setSize(window.innerWidth - 50, window.innerHeight * 0.5);
    sdg.render();

    // population
    // groups = new Groups(document.querySelector("#population svg"), callbackPopulation, backToNormalPopulation);
    // groups.labels(labels);
    // groups.data(getDataPopulation(projects_by_population["population_counts"]));
    // groups.color(defaultColor);
    // groups.setSize(document.querySelector("#population").offsetWidth - 20, window.innerHeight * 0.5);
    // groups.render();

    // timeline
    projects = new Projects(document.querySelector("#timeline svg"));
    projects.data(timelineData);
    projects.color(defaultColor);
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
      // timeline
      projects.sub(Math.random() > .5? getSubTimeline(projects.data()) : null);
      projects.color(COLORS[Math.round(Math.random() * (COLORS.length - 1))]);
      projects.render();
    })
  }
})
