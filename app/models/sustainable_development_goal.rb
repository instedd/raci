class SustainableDevelopmentGoal < ApplicationRecord

  attr_accessor :url
  attr_accessor :number
  attr_accessor :name

  def self.all
    [
      SustainableDevelopmentGoal.new(name: 'Fin de la pobreza', url: 'fin-de-la-pobreza', number: 1),
      SustainableDevelopmentGoal.new(name: 'Hambre cero', url: 'hambre-cero', number: 2),
      SustainableDevelopmentGoal.new(name: 'Salud y bienestar', url: 'salud-y-bienestar', number: 3),
      SustainableDevelopmentGoal.new(name: 'Educación de calidad', url: 'educacion-de-calidad', number: 4),
      SustainableDevelopmentGoal.new(name: 'Igualdad de género', url: 'igualdad-de-genero', number: 5),
      SustainableDevelopmentGoal.new(name: 'Agua limpia y saneamiento', url: 'agua-limpia-y-saneamiento', number: 6),
      SustainableDevelopmentGoal.new(name: 'Energía asequible y no contaminante', url: 'energia-asequible-y-no-contaminante', number: 7),
      SustainableDevelopmentGoal.new(name: 'Trabajo decente y crecimiento económico', url: 'trabajo-decente-y-crecimiento-economico', number: 8),
      SustainableDevelopmentGoal.new(name: 'Industria innovación e infraestructura', url: 'industria-innovacion-e-infraestructura', number: 9),
      SustainableDevelopmentGoal.new(name: 'Reducción de las desigualdades', url: 'reduccion-de-las-desigualdades', number: 10),
      SustainableDevelopmentGoal.new(name: 'Ciudades y comunidades sostenibles', url: 'ciudades-y-comunidades-sostenibles', number: 11),
      SustainableDevelopmentGoal.new(name: 'Producción y consumo responsables', url: 'produccion-y-consumo-responsables', number: 12),
      SustainableDevelopmentGoal.new(name: 'Acción por el clima', url: 'accion-por-el-clima', number: 13),
      SustainableDevelopmentGoal.new(name: 'Vida submarina', url: 'vida-submarina', number: 14),
      SustainableDevelopmentGoal.new(name: 'Vida de ecosistemas terrestres', url: 'vida-de-ecosistemas-terrestres', number: 15),
      SustainableDevelopmentGoal.new(name: 'Paz justicia e instituciones sólidas', url: 'paz-justicia-e-instituciones-solidas', number: 16),
      SustainableDevelopmentGoal.new(name: 'Alianzas para lograr los objetivos', url: 'alianzas-para-lograr-los-objetivos', number: 17)
    ]
  end

  def self.find(id)
    all.find{|g| g.number == id.to_i}
  end
end
