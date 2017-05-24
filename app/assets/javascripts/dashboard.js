$(document).on('turbolinks:load', function(){
  if($('#dashboard').length > 0) {
    var map;
    var COLORS = ["#e5243b", "#dda63a", "#4c9f38", "#c5192d", "#ff3a21", "#26bde2", "#fcc30b", "#a21942", "#fd6925", "#dd1367", "#fd9d24", "#bf8b2e", "#3f7e44", "#0a97d9", "#56c02b", "#00689d", "#19486a"];
    var defaultColor = "#1f4388";
    var PROVINCES = ["BA", "CABA", "CAT", "CBA", "CHO", "CHT", "COR", "ER", "FSA", "JUJ", "LP", "LR", "MIS", "MZA", "NEU", "RN", "SAL", "SC", "SE", "SF", "SJ", "SL", "TF", "TUC"];
    var sdg;
    var groups;
    var projects;

    function callbackSdg(id) {
      // population
      groups.sub(getDataPopulation(projects_by_population["by_sdg"][id]));
      groups.color(COLORS[id-1]);
      groups.render();

      // map
      map.data(getDataMap(projects_by_location["by_sdg"][id]));
      map.color(COLORS[id-1]);
      map.render();

      // timeline
      projects.sub(getDataTimeline(projects_by_upload_date["by_sdg"][id]));
      projects.color(COLORS[id-1]);
      projects.render();
    }

    function backToNormalSdg(id) {
      groups.color(defaultColor);
      groups.sub(null);
      groups.render();

      map.data(getDataMap(projects_by_location["location_counts"]));
      map.color(defaultColor);
      map.render();

      projects.sub(null);
      projects.color(defaultColor);
      projects.render();
    }

    function callbackMap(id) {
      // sdgs
      sdg.sub(getDataSdg(projects_by_sdg["by_location"][id]));
      sdg.render();

      // population
      groups.sub(getDataPopulation(projects_by_population["by_location"][id]));
      groups.render();

      // timeline
      projects.sub(getDataTimeline(projects_by_upload_date["by_location"][id]));
      projects.render();
    }

    function backToNormalMap(id) {
      // population
      groups.sub(null);
      groups.render();
      // sdgs
      sdg.sub(null);
      sdg.render();
      // timeline
      projects.sub(null);
      projects.render();
    }

    function callbackPopulation(id) {
      // sdgs
      sdg.sub(getDataSdg(projects_by_sdg["by_population"][id]));
      sdg.render();

      // map
      map.data(getDataMap(projects_by_location["by_population"][id]));
      map.render();
      // timeline
      projects.sub(getDataTimeline(projects_by_upload_date["by_population"][id]));
      projects.render();
    }

    function backToNormalPopulation(id) {
      map.data(getDataMap(projects_by_location["location_counts"]));
      map.render();

      sdg.sub(null);
      sdg.render();

      projects.sub(null);
      projects.render();
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

    function getDataTimeline(original) {
      data = []
      if(original) {
        original.forEach(function (d){
          data.push([new Date (d[0]), d[1]]);
        })
        data.sort(function(a,b){
          return b[0] - a[0];
        });
        data = data.slice(0,6);
      }
      return data;
    }

    var map_width = function(){return document.querySelector("#map").offsetWidth - 50};
    var ods_width = function(){return window.innerWidth - 100};
    var timeline_width = function(){return document.querySelector("#timeline").offsetWidth - 20};
    var population_width = function(){return document.querySelector("#population").offsetWidth - 20};
    var general_chart_height = function(){return window.innerHeight * 0.5};
    // map
    map = new Map(document.querySelector("#map svg"), callbackMap, backToNormalMap);
    map.data(getDataMap(projects_by_location["location_counts"]));
    map.color(defaultColor);
    console.log(map_width())
    map.setSize(map_width(), general_chart_height());
    map.render();

    // sdgs
    sdg = new ODS(document.querySelector("svg#sdg-chart"), callbackSdg, backToNormalSdg);
    sdg.data(getDataSdg(projects_by_sdg["sdg_counts"]));
    sdg.setSize(ods_width(), general_chart_height());
    sdg.render();

    // population
    groups = new Groups(document.querySelector("#population svg"), callbackPopulation, backToNormalPopulation);
    groups.labels(labels);
    groups.data(getDataPopulation(projects_by_population["population_counts"]));
    groups.color(defaultColor);
    groups.setSize(population_width(), general_chart_height());
    groups.render();

    // timeline
    projects = new Projects(document.querySelector("#timeline svg"));
    projects.data(getDataTimeline(projects_by_upload_date["timeline_counts"]));
    projects.color(defaultColor);
    projects.setSize(timeline_width(), general_chart_height());
    projects.render();

    window.addEventListener("resize", function (e) {
      // map
      map.setSize(map_width(), general_chart_height());
      map.render();

      // sdgs
      sdg.setSize(ods_width(), general_chart_height());
      sdg.render();

      // population
      groups.setSize(population_width(), general_chart_height());
      groups.render();

      //timeline
      projects.setSize(timeline_width(), general_chart_height());
      projects.render();
    });
  }
})
