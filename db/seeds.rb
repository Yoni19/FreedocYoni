# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

nbcity = 20
nbdoctor = 100
nbpatient = 1000
nbappointment = 2000
array_specialty = ["Generaliste","DUCUL","Gastrofion"]
doctors = []
patients = []
cities = []
specialties = []

#Seed des 20 villes
nbcity.times do |x|
  city = City.create(name: Faker::Address.city)
  cities << city
  puts "Seed City :#{x}"
end
#Seed des X Specialités
array_specialty.size.times do |x|
  specialty = Specialty.create(name: array_specialty[x])
  specialties << specialty
  puts "Seed Specialty : #{x}"
end
#Patient seed - Creation de 1000 patients
nbpatient.times do |x|
  patient = Patient.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    city_id: cities[rand(0..nbcity-1)].id)
    patients << patient
  puts "Seed  Patient : #{x}"
end
#Doctor seed - Creation de 100 docteurs
nbdoctor.times do |x|
	doctor = Doctor.create(
    first_name: Faker::Name.first_name, 
    last_name: Faker::Name.last_name,
    zip_code: Faker::Address.zip_code,
    city: cities[rand(0..nbcity-1)])
    doctors << doctor
  puts "Seed Doctor :#{x}"
end
#Appointment seed - Creation de 2000 appointments
t1 = Time.parse("2019-10-23 14:40:34")
t2 = Time.parse("2021-01-01 00:00:00")
nbappointment.times do |x|
  appointment = Appointment.create(
    doctor_id: doctors[rand(0..nbdoctor-1)].id,
    patient_id: patients[rand(0..nbpatient-1)].id,
    city_id: cities[rand(0..nbcity-1)].id,
    date: rand(t1..t2))
  puts "Seed Appointment :#{x}"
end
#creation d'une specialité par docteur
nbdoctor.times do |x|
  doc_spe = DoctorSpecialty.create(
    doctor_id: doctors[x].id,
    specialty_id: specialties[rand(1..array_specialty.size-1)].id)
  puts "Seed  de specialty a  Doctor :#{x}"
end
#ajout de specialités aleatoires
50.times do |x|
  doc_spe = DoctorSpecialty.create(
    doctor_id: doctors[rand(0..nbdoctor-1)].id,
    specialty_id: specialties[rand(1..array_specialty.size-1)].id)
  puts "Seed de la  specialty aleatoire a un Doctor : #{x}"
end