batch = [{:name => "mongodb"}, {:name => "mongoid"}]
Article.collection.insert(batch)

# db[:article].insert([{name: "John"}, {name: "Joe"}])
