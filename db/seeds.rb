User.destroy_all
BMail.destroy_all

User.create([
  {
    email: "annie@gmail.com",
    password: "seaweed",
    password_confirmation: "seaweed"
  },
  {
    email: "kulio@gmail.com",
    password: "123",
    password_confirmation: "123"
  },
  {
    email: "mark@gmail.com",
    password: "sake",
    password_confirmation: "sake"
  },
  {
    email: "marco@gmail.com",
    password: "wegotdeathstar",
    password_confirmation: "wegotdeathstar"
  },
  {
    email: "christian@gmail.com",
    password: "integrity",
    password_confirmation: "integrity"
  },
  {
    email: "anil@gmail.com",
    password: "nil",
    password_confirmation: "nil"
  },
  {
    email: "simon@gmail.com",
    password: "says",
    password_confirmation: "says"
  },
  {
    email: "charles@gmail.com",
    password: "ruleroftheworld",
    password_confirmation: "ruleroftheworld"
  },
  {
    email: "charlie@gmail.com",
    password: "starrysocks",
    password_confirmation: "starrysocks"
  },
  {
    email: "harry@gmail.com",
    password: "speeddemon",
    password_confirmation: "speeddemon"
  },
  {
    email: "julie@gmail.com",
    password: "bananas",
    password_confirmation: "bananas"
  },
  {
    email: "muwah@gmail.com",
    password: "adventure",
    password_confirmation: "adventure"
  },
  {
    email: "joseph@gmail.com",
    password: "secretgenius",
    password_confirmation: "secretgenius"
  },
  {
    email: "nigel@gmail.com",
    password: "golf",
    password_confirmation: "golf"
  },
  {
    email: "victor@gmail.com",
    password: "2chicken",
    password_confirmation: "2chicken"
  },
  {
    email: "alex@gmail.com",
    password: "onimask",
    password_confirmation: "onimask"
  },
])

BMail.create([
  {
    title: "test1",
    to: "abc@example.com, cnn@example.com",
    content: "For your eyes only."
  },
  {
    title: "test2",
    to: "bbc@example.com, cnn@example.com",
    content: "This will change your world."
  },
  {
    title: "test3",
    to: "aljazeera@example.com, morpheus@example.com",
    content: "This is a red pill, blue pill thing."
  },
])