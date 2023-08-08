10.times do |i|
  User.create(username: "user#{i}", first_name: "fname", last_name: "lname", email: "email#{i}@gmail.com")
end

11.times do |i|
  i = i + 4
  5.times do |j|
    Blog.create(title: "Hello Blog#{j} of user#{i}", body: "Welcome to blog#{j} of user#{i}", visible: true, user_id: i)
  end
end

10.times do |u|
  u = u + 4
  50.times do |i|
    i = i + 1
    Like.create(blog_id: i, user_id: u)
  end
end

50.times do |b|
  b = b + 1
  10.times do |u|
    u = u + 4
    Comment.create(comment: "Comment of user #{u} on blog #{b}", blog_id: b, user_id: u)
  end
end

ua = User.all
ba = Blog.all

ba.each do |b|
  ca = b.comments
  ca.each do |c|
    ua.each do |u|
      Comment.create(comment: "Replied on comment #{c.id}", blog_id: b.id, user_id: u.id, replied_on: c.id)
    end
  end
end

ua = User.all

ua.each do |u|
  uf = User.all
  uf.each do |f|
    u.following.create(user_id: f.id)
  end
end
