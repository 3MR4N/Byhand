import express from 'express';
import User from './src/routes/user'
import Product from './src/routes/product'
import Rate from './src/routes/rate'
import Favorite from './src/routes/favorite'
import Category from './src/routes/category'
import Notifications from './src/routes/notifications'
import Notes from './src/routes/notes'
import Packages from './src/routes/package'
var router = express.Router();
import ProductsController from './src/controllers/ProductsController'
import AuthController from './src/controllers/AuthController'
import CategorysController from './src/controllers/CategorysController'
const app = express();

app.use(express.urlencoded({ extended: true }));
app.use(express.json());


app.use("/users", User);
app.use("/products", Product);
app.use("/rates", Rate);
app.use("/favorites", Favorite);
app.use("/category", Category);
app.use("/notifications", Notifications);
app.use("/notes", Notes);
app.use("/packages", Packages);


let multer = require("multer")

let storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "uploads")
  },
  filename: function (req, file, cb) {
    let ext = file.mimetype.split("/")
    ext = ext[ext.length - 1]
    cb(null, 'image' + Date.now() + "." + ext)
  }
})

let upload = multer({ storage: storage });

app.get("/", (req, res) => {
  res.sendFile('')
})

app.use('/uploads', express.static('./uploads'));

// app.use("/product/image/cate", upload.single("photos"),router.post('/', CategorysController.create))



app.use("/product/image", upload.single("photos"),router.post('/', ProductsController.create))
app.use("/product/image/user", upload.single("photos"),router.put('/:id', AuthController.update))




const port = 9009;

app.listen(port, () => {
  console.log('App is now running at port ', port)
})
