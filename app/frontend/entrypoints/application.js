import "@/stylesheets/index.scss";
import "@hotwired/turbo-rails";
import "flowbite";
import "flowbite/dist/flowbite.turbo";
import "apexcharts/dist/apexcharts";

import "@/controllers";
import "@/controllers/admin";
import "@/controllers/shared";
import "@/controllers/users";
import "@/controllers/rooms";
import "@/controllers/chart";

import "@/channels";

import.meta.globEager("@/images/**/*.svg");
