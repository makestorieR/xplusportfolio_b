# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# 30.times do |n|

# 	user = User.create name: "User #{n}", email: "user#{n}@mail.com", password: "password"
# 	user.confirm


# end


# Technology.create name: "Ruby On Rails"
# Technology.create name: "Javascript"
# Technology.create name: "React"
# Technology.create name: "Ruby"
# Technology.create name: "HTML"
# Technology.create name: "CSS"
# Technology.create name: "GIT"


# AnticipationCover.create name: "Rusty", image: "https://images.unsplash.com/photo-1609602644879-dd158c2b56b4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dGV4dHVyZSUyMGJhY2tncm91bmR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60", text_color: "white"
# AnticipationCover.create name: "Fabric", image: "https://images.unsplash.com/photo-1528459105426-b9548367069b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHRleHR1cmUlMjBiYWNrZ3JvdW5kfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60", text_color: "white"
# AnticipationCover.create name: "Oman", image: "https://images.unsplash.com/photo-1530176928500-2372a88e00b5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fHRleHR1cmUlMjBiYWNrZ3JvdW5kfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60", text_color: "black"
# AnticipationCover.create name: "Wooden", image: "https://images.unsplash.com/photo-1583418007992-a8e33a92e7ad?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjZ8fHRleHR1cmUlMjBiYWNrZ3JvdW5kfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60", text_color: "black"
# AnticipationCover.create name: "Gray", image: "https://images.unsplash.com/photo-1533035353720-f1c6a75cd8ab?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjN8fHRleHR1cmUlMjBiYWNrZ3JvdW5kfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60", text_color: "black"
# AnticipationCover.create name: "Grey Concrete", image: "https://images.unsplash.com/photo-1575722290270-626b0208df99?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzJ8fHRleHR1cmUlMjBiYWNrZ3JvdW5kfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60", text_color: "white"
# AnticipationCover.create name: "Astronomy", image: "https://images.unsplash.com/photo-1566198602184-30a482db864a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDJ8fHRleHR1cmUlMjBiYWNrZ3JvdW5kfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60", text_color: "white


# User.all.each do |user|

# 	BackgroundCoverPhoto.create user: user
# end

# json.(resource, :id, :img_url, :title, :desc, :link, :color, :video_url)


[
	{
		img_url: "https://res.cloudinary.com/dn6vnxbnm/image/upload/v1648903934/resources/free_vsu7xp.png",
		title: "freeCodeCamp",
		desc: "freeCodeCamp is a non-profit organization that consists of an interactive learning web platform, an online community forum, chat rooms, online publications and local organizations that intend to make learning web development accessible to anyone.",
		link: "https://www.freecodecamp.org/",
		video_url: nil,
	},

	{
		img_url: "https://res.cloudinary.com/dn6vnxbnm/image/upload/v1648903810/resources/yearone-removebg-preview_ar1c4l.png",
		title: "YearOne (Techstars 2020)",
		desc: "We help code schools grads land incredible jobs and support through their early careers in tech companies.",
		link: "https://www.joinyearone.io/",
		video_url: nil,
	},

	{
		img_url: "https://res.cloudinary.com/dn6vnxbnm/image/upload/v1648903706/resources/odin_project-removebg-preview_wqhnpw.png",
		title: "The Odin Project",
		desc: "The Odin Project provides a free open source coding curriculum that can be taken entirely online. Since its inception, it has helped many students get hired as developers and has assisted countless others in learning enough programming to work on their own personal projects.",
		link: "https://www.theodinproject.com/",
		video_url: nil,
	}
].each do |jobboard|

	Resource.create title: jobboard[:title], desc: jobboard[:desc], link: jobboard[:link], video_url: jobboard[:video_url], img_url: jobboard[:img_url], resource_type: 'community'
	

end



