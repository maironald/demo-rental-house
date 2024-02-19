import { Controller } from "@hotwired/stimulus";
import ApexCharts from "apexcharts";

export default class extends Controller {
  static values = { benefit: String };

  connect() {
    this.initializeCharts();
  }

  getValue() {
    const benefitValue1 = this.benefitValue;
    return JSON.parse(benefitValue1);
  }

  initializeCharts() {
    const sparklineData = [
      // 47, 45, 54, 38, 56, 24, 65, 31, 37, 39, 62, 51, 35, 41, 35, 27, 93, 53,
      // 61, 27, 54, 43, 19, 46,
    ];
    const spark1Options = {
      chart: {
        id: "sparkline1",
        group: "sparklines",
        type: "area",
        height: 160,
        sparkline: {
          enabled: true,
        },
        background: "#FFFFFF",
      },
      stroke: {
        curve: "straight",
      },
      fill: {
        opacity: 1,
      },
      series: [
        {
          name: "THU",
          data: this.randomizeArray(sparklineData),
        },
      ],
      labels: [],
      yaxis: {
        min: 0,
      },
      xaxis: {
        type: "datetime",
      },
      colors: ["#FBBF24"],
      title: {
        text: "TỔNG THU LÝ THUYẾT",
        offsetX: 10,
        offsetY: 20,
        style: {
          fontSize: "24px",
          cssClass: "apexcharts-yaxis-title",
          color: "#FBBF24",
        },
      },
      subtitle: {
        text: `${this.getValue().total_benefit_theory} VND`,
        offsetX: 30,
        offsetY: 60,
        style: {
          fontSize: "24px",
          cssClass: "apexcharts-yaxis-title",
          fontWeight: "bold",
        },
      },
    };

    const spark2Options = {
      chart: {
        id: "sparkline1",
        group: "sparklines",
        type: "area",
        height: 160,
        sparkline: {
          enabled: true,
        },
        background: "#FFFFFF",
      },
      stroke: {
        curve: "straight",
      },
      fill: {
        opacity: 1,
      },
      series: [
        {
          name: "THU",
          data: this.randomizeArray(sparklineData),
        },
      ],
      labels: [...Array(24).keys()].map((n) => `2018-09-0${n + 1}`),
      yaxis: {
        min: 0,
      },
      xaxis: {
        type: "datetime",
      },
      colors: ["#16A34A"],
      title: {
        text: "TỔNG THU THỰC TẾ",
        offsetX: 10,
        offsetY: 20,
        style: {
          fontSize: "24px",
          cssClass: "apexcharts-yaxis-title",
          color: "#16A34A",
        },
      },
      subtitle: {
        text: `${this.getValue().total_benefit_real} VND`,
        offsetX: 30,
        offsetY: 60,
        style: {
          fontSize: "24px",
          cssClass: "apexcharts-yaxis-title",
          fontWeight: "bold",
        },
      },
    };

    const spark3Options = {
      chart: {
        id: "sparkline2",
        group: "sparklines",
        type: "area",
        height: 160,
        sparkline: {
          enabled: true,
        },
        background: "#FFFFFF",
      },
      stroke: {
        curve: "straight",
      },
      fill: {
        opacity: 1,
      },
      series: [
        {
          name: "CHI",
          data: this.randomizeArray(sparklineData),
        },
      ],
      labels: [...Array(24).keys()].map((n) => `2018-09-0${n + 1}`),
      yaxis: {
        min: 0,
      },
      xaxis: {
        type: "datetime",
      },
      colors: ["#EF4444"],
      title: {
        text: "TỔNG CHI",
        offsetX: 10,
        offsetY: 20,
        style: {
          fontSize: "24px",
          cssClass: "apexcharts-yaxis-title",
          color: "#EF4444",
        },
      },
      subtitle: {
        text: `${this.getValue().total_expenditure} VND`,
        offsetX: 30,
        offsetY: 60,
        style: {
          fontSize: "24px",
          cssClass: "apexcharts-yaxis-title",
          fontWeight: "bold",
        },
      },
    };

    const spark4Options = {
      chart: {
        id: "sparkline3",
        group: "sparklines",
        type: "area",
        height: 160,
        sparkline: {
          enabled: true,
        },
        background: "#FFFFFF",
      },
      stroke: {
        curve: "straight",
      },
      fill: {
        opacity: 1,
      },
      series: [
        {
          name: "Profits",
          data: this.randomizeArray(sparklineData),
        },
      ],
      labels: [...Array(24).keys()].map((n) => `2018-09-0${n + 1}`),
      xaxis: {
        type: "datetime",
      },
      yaxis: {
        min: 0,
      },
      colors: ["#008FFB"],
      title: {
        text: "TỔNG LỢI NHUẬN",
        offsetX: 10,
        offsetY: 20,
        style: {
          fontSize: "24px",
          cssClass: "apexcharts-yaxis-title",
          color: "#008FFB",
        },
      },
      subtitle: {
        text: `${this.getValue().total_benefit_real - this.getValue().total_expenditure} VND`,
        offsetX: 30,
        offsetY: 60,
        style: {
          fontSize: "24px",
          cssClass: "apexcharts-yaxis-title",
          fontWeight: "bold",
        },
      },
    };

    this.renderChart("sparkline1", spark1Options);
    this.renderChart("sparkline2", spark2Options);
    this.renderChart("sparkline3", spark3Options);
    this.renderChart("sparkline4", spark4Options);
  }

  renderChart(chartId, options) {
    const chartElement = document.getElementById(chartId);

    if (chartElement) {
      const chart = new ApexCharts(chartElement, options);
      chart.render();
    }
  }

  randomizeArray(arg) {
    const array = arg.slice();
    let currentIndex = array.length;
    let temporaryValue;
    let randomIndex;

    while (currentIndex !== 0) {
      randomIndex = Math.floor(Math.random() * currentIndex);
      currentIndex -= 1;

      temporaryValue = array[currentIndex];
      array[currentIndex] = array[randomIndex];
      array[randomIndex] = temporaryValue;
    }

    return array;
  }
}
