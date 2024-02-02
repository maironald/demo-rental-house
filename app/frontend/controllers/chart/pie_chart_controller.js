import { Controller } from "@hotwired/stimulus";
import ApexCharts from "apexcharts";

export default class extends Controller {
  static values = { room: String };

  connect() {
    this.renderChart();
  }

  getValue() {
    const roomValue1 = this.roomValue;
    return JSON.parse(roomValue1);
  }

  renderChart() {
    const options = {
      series: [
        this.getValue().amount_room_nil,
        this.getValue().total_amount_room,
      ],
      colors: ["#1C64F2", "#16BDCA"],
      chart: {
        height: 420,
        width: "100%",
        type: "pie",
      },
      stroke: {
        colors: ["white"],
        lineCap: "",
      },
      plotOptions: {
        pie: {
          labels: {
            show: true,
          },
          size: "100%",
          dataLabels: {
            offset: -25,
          },
        },
      },
      labels: ["Phòng trống", "Phòng cho thuê"],
      dataLabels: {
        enabled: true,
        style: {
          fontFamily: "Inter, sans-serif",
        },
      },
      legend: {
        position: "bottom",
        fontFamily: "Inter, sans-serif",
      },
    };

    if (this.element && typeof ApexCharts !== "undefined") {
      const chart = new ApexCharts(this.element, options);
      chart.render();
    }
  }
}
