// Import and register all your controllers from the importmap under controllers/*

import { application } from "./application"

import PostsController from "./posts_controller"
application.register("posts", PostsController)

import ToastController from "./toast_controller"
application.register("toast", ToastController)

import AutohideController from "./autohide_controller"
application.register("autohide", AutohideController)
