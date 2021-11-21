import { Controller } from "@hotwired/stimulus";
import anime from "animejs";
export default class extends Controller {
  connect() {
    const config = {
    const config = {
      translateZ: 0,
      translateX: ["-105%", "105%"],
    };

    export const reveal = async () => {
      const headline = this.element;
      const parts = headline.textContent.split(" ");
      headline.innerHTML = parts
        .map(
          (p) =>
            `<span><span>${p}</span><span class="uiui-block"></span></span>`
        )
        .join(" ");
      const blocks = [...document.querySelectorAll(".example-7 .uiui-block")];
      for (const elem of blocks) {
        await revealHeading({ elem, config });
        elem.previousSibling.style.opacity = 1;
      }
    };

    export const revealHeading = ({ elem, config }) => {
      return new Promise((resolve) => {
        anime({
          targets: elem,
          easing: "spring(1, 60, 15, 3)",
          ...config,

          update: (a) => {
            a.progress > 10 && resolve(elem);
            elem.classList.add("Revealed");
          },
        });
      });
    },
      translateZ: 0,
      translateX: ["-105%", "105%"],
    };

    export const reveal = async () => {
      const headline = this.element;
      const parts = headline.textContent.split(" ");
      headline.innerHTML = parts
        .map(
          (p) =>
            `<span><span>${p}</span><span class="uiui-block"></span></span>`
        )
        .join(" ");
      const blocks = [...document.querySelectorAll(".example-7 .uiui-block")];
      for (const elem of blocks) {
        await revealHeading({ elem, config });
        elem.previousSibling.style.opacity = 1;
      }
    };

    export const revealHeading = ({ elem, config }) => {
      return new Promise((resolve) => {
        anime({
          targets: elem,
          easing: "spring(1, 60, 15, 3)",
          ...config,

          update: (a) => {
            a.progress > 10 && resolve(elem);
            elem.classList.add("Revealed");
          },
        });
      });
    };

    reveal();
  }
  text_anime() {

  }
}
