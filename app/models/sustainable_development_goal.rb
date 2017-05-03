class SustainableDevelopmentGoal < ApplicationRecord

  attr_accessor :url
  attr_accessor :number
  attr_accessor :color

  def self.all
    [
      SustainableDevelopmentGoal.new(url: 'fin-de-la-pobreza', number: 1),
      SustainableDevelopmentGoal.new(url: 'hambre-cero', number: 2),
      SustainableDevelopmentGoal.new(url: 'salud-y-bienestar', number: 3),
      SustainableDevelopmentGoal.new(url: 'educacion-de-calidad', number: 4),
      SustainableDevelopmentGoal.new(url: 'igualdad-de-genero', number: 5),
      SustainableDevelopmentGoal.new(url: 'agua-limpia-y-saneamiento', number: 6),
      SustainableDevelopmentGoal.new(url: 'energia-asequible-y-no-contaminante', number: 7),
      SustainableDevelopmentGoal.new(url: 'trabajo-decente-y-crecimiento-economico', number: 8),
      SustainableDevelopmentGoal.new(url: 'industria-innovacion-e-infraestructura', number: 9),
      SustainableDevelopmentGoal.new(url: 'reduccion-de-las-desigualdades', number: 10),
      SustainableDevelopmentGoal.new(url: 'ciudades-y-comunidades-sostenibles', number: 11),
      SustainableDevelopmentGoal.new(url: 'produccion-y-consumo-responsables', number: 12),
      SustainableDevelopmentGoal.new(url: 'accion-por-el-clima', number: 13),
      SustainableDevelopmentGoal.new(url: 'vida-submarina', number: 14),
      SustainableDevelopmentGoal.new(url: 'vida-de-ecosistemas-terrestres', number: 15),
      SustainableDevelopmentGoal.new(url: 'paz-justicia-e-instituciones-solidas', number: 16),
      SustainableDevelopmentGoal.new(url: 'alianzas-para-lograr-los-objetivos', number: 17)
    ]
  end
end
