#User
5.times do |i|
  i += 1
  User.create(username: "user#{i}", email: "user#{i}@email.com", password: "User@#{i}")
end

#Profile
User.all.each_with_index do |u, i|
  u.create_profile(first_name: "fname", last_name: "lname", date_of_birth: Date.today - (18 + i + 2).year - (i + 5).month, about: "Interested in ROR")
end

#Followers_Following
User.all.each do |u1|
  User.all.each do |u2|
    u1.followers.create(follower_user_id: u2.id)
  end
end

#Blog
User.all.each do |u, i|
  5.times do |bn|
    bn += 1
    u.blogs.create({ title: "Blog no. #{bn} of #{u.username}", body: "Welcome to blog#{bn} of #{u.username}", visible: true })
  end
end

#Comment
Blog.all.each do |b|
  User.all.each do |u|
    b.comments.create(comment_text: "Comment by #{u.username}", user_id: u.id)
  end
end

#Replies on comment
Blog.all.each do |b|
  b.comments.each do |c|
    User.all.each do |u|
      c.replies.create(comment_text: "Replied on comment#{c.id} by #{u.username}", blog_id: b.id, user_id: u.id)
    end
  end
end

#Like
Blog.all.each do |b|
  User.all.each do |u|
    b.likes.create(user_id: u.id)
  end
end
