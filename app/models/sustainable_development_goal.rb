class SustainableDevelopmentGoal
  include ActiveModel::Model
  attr_accessor :url
  attr_accessor :number
  attr_accessor :name
  attr_accessor :title

  def self.all
    [
      SustainableDevelopmentGoal.new(name: 'Fin de la pobreza', url: 'fin-de-la-pobreza', number: 1, title: "Poner fin a la pobreza en todas sus formas en todo el mundo"),
      SustainableDevelopmentGoal.new(name: 'Hambre cero', url: 'hambre-cero', number: 2, title: "Poner fin al hambre, lograr la seguridad alimentaria y la mejora de la nutrición y promover la agricultura sostenible"),
      SustainableDevelopmentGoal.new(name: 'Salud y bienestar', url: 'salud-y-bienestar', number: 3, title: "Garantizar una vida sana y promover el bienestar para todos en todas las edades"),
      SustainableDevelopmentGoal.new(name: 'Educación de calidad', url: 'educacion-de-calidad', number: 4, title: "Garantizar una educación inclusiva, equitativa y de calidad y promover oportunidades de aprendizaje durante toda la vida para todos"),
      SustainableDevelopmentGoal.new(name: 'Igualdad de género', url: 'igualdad-de-genero', number: 5, title: "Lograr la igualdad entre los géneros y empoderar a todas las mujeres y las niñas"),
      SustainableDevelopmentGoal.new(name: 'Agua limpia y saneamiento', url: 'agua-limpia-y-saneamiento', number: 6, title: "Garantizar la disponibilidad de agua y su gestión sostenible y el saneamiento para todos"),
      SustainableDevelopmentGoal.new(name: 'Energía asequible y no contaminante', url: 'energia-asequible-y-no-contaminante', number: 7, title: "Garantizar el acceso a una energía asequible, segura, sostenible y moderna para todos"),
      SustainableDevelopmentGoal.new(name: 'Trabajo decente y crecimiento económico', url: 'trabajo-decente-y-crecimiento-economico', number: 8, title: "Promover el crecimiento económico sostenido, inclusivo y sostenible, el empleo pleno y productivo y el trabajo decente para todos"),
      SustainableDevelopmentGoal.new(name: 'Industria innovación e infraestructura', url: 'industria-innovacion-e-infraestructura', number: 9, title: "Construir infraestructuras resilientes, promover la industrialización inclusiva y sostenible y fomentar la innovación"),
      SustainableDevelopmentGoal.new(name: 'Reducción de las desigualdades', url: 'reduccion-de-las-desigualdades', number: 10, title: "Reducir la desigualdad en y entre los países"),
      SustainableDevelopmentGoal.new(name: 'Ciudades y comunidades sostenibles', url: 'ciudades-y-comunidades-sostenibles', number: 11, title: "Lograr que las ciudades y los asentamientos humanos sean inclusivos, seguros, resilientes y sostenibles"),
      SustainableDevelopmentGoal.new(name: 'Producción y consumo responsables', url: 'produccion-y-consumo-responsables', number: 12, title: "Garantizar modalidades de consumo y producción sostenibles"),
      SustainableDevelopmentGoal.new(name: 'Acción por el clima', url: 'accion-por-el-clima', number: 13, title: "Adoptar medidas urgentes para combatir el cambio climático y sus efectos"),
      SustainableDevelopmentGoal.new(name: 'Vida submarina', url: 'vida-submarina', number: 14, title: "Conservar y utilizar en forma sostenible los océanos, los mares y los recursos marinos para el desarrollo sostenible"),
      SustainableDevelopmentGoal.new(name: 'Vida de ecosistemas terrestres', url: 'vida-de-ecosistemas-terrestres', number: 15, title: "Gestionar sosteniblemente los bosques, luchar contra la desertificación, detener e invertir la degradación de las tierras y detener la pérdida de biodiversidad"),
      SustainableDevelopmentGoal.new(name: 'Paz justicia e instituciones sólidas', url: 'paz-justicia-e-instituciones-solidas', number: 16, title: "Promover sociedades, justas, pacíficas e inclusivas"),
      SustainableDevelopmentGoal.new(name: 'Alianzas para lograr los objetivos', url: 'alianzas-para-lograr-los-objetivos', number: 17, title: "Revitalizar la Alianza Mundial para el Desarrollo Sostenible")
    ]
  end

  def self.find(id)
    all.find{|g| g.number == id.to_i}
  end
end
