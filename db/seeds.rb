# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "digest/md5"

5.times do |i|
    Post.create(title: "はじめまして#{i}です！",body: "趣味は#{i}つあります。", password:"#{Digest::SHA256.hexdigest(i.to_s)}",author: "#{i}さん")
end