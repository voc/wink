let itemFilterTimer;
let itemFilterValue = "";

document.addEventListener("turbo:load", () => {
  const input = document.querySelector("#item_filter.item_index");
  const clearBtn = document.querySelector("#item_filter_clear");
  const spinner = document.querySelector(".spinner");

  if (!input) return; // nothing to do if field is missing

  const filterAction = () => {
    const value = input.value;
    const pattern = new RegExp(value, "i");

    document.querySelectorAll("table").forEach((table) => {
      let shownCount = 0;

      table.querySelectorAll("tbody tr").forEach((row) => {
        const text = row.innerText;
        if (pattern.test(text)) {
          row.style.display = "";
          shownCount++;
        } else {
          row.style.display = "none";
        }
      });

      table.style.display = shownCount === 0 ? "none" : "";
    });

    itemFilterValue = value;

    if (value !== "") {
      clearBtn.style.visibility = "visible";
    } else {
      clearBtn.style.visibility = "hidden";
    }

    if (spinner) spinner.style.visibility = "hidden";
  };

  const debounceDelay = 500;

  // Keyup → debounce filter
  input.addEventListener("keyup", () => {
    if (itemFilterValue !== input.value) {
      clearTimeout(itemFilterTimer);
      itemFilterTimer = setTimeout(filterAction, debounceDelay);
      if (spinner) spinner.style.visibility = "visible";
    }
  });

  // Keydown → cancel pending filter
  input.addEventListener("keydown", () => {
    clearTimeout(itemFilterTimer);
    if (spinner) spinner.style.visibility = "hidden";
  });

  // Clear button
  clearBtn.addEventListener("click", () => {
    clearBtn.style.visibility = "hidden";
    input.value = "";
    filterAction();
  });
});