let itemFilterTimer;
let itemFilterValue = '';

document.addEventListener("turbo:load", () => {
  const itemFilter = document.querySelector("#item_filter.case_show");
  const clearButton = document.querySelector("#item_filter_clear");
  const spinner = document.querySelector(".spinner");

  if (!itemFilter) return; // no filter input on this page

  const itemFilterAction = () => {
    const value = itemFilter.value;
    const pattern = new RegExp(value, "i");

    document.querySelectorAll(".active_items").forEach(container => {
      let shownCount = 0;
      const rows = container.querySelectorAll("tbody tr");
      rows.forEach(row => {
        const text = row.innerText;
        if (pattern.test(text)) {
          row.style.display = "";
          shownCount++;
        } else {
          row.style.display = "none";
        }
      });

      container.style.display = shownCount === 0 ? "none" : "";
    });

    itemFilterValue = value;

    if (value !== "") {
      clearButton.style.visibility = "visible";
      document.querySelectorAll(".flagged").forEach(e => e.style.display = "none");
      document.querySelectorAll(".deleted").forEach(e => e.style.display = "none");
    } else {
      clearButton.style.visibility = "hidden";
      document.querySelectorAll(".flagged").forEach(e => e.style.display = "");
      document.querySelectorAll(".deleted").forEach(e => e.style.display = "none");
    }

    spinner.style.visibility = "hidden";
  };

  const timeout = 500;

  // Keyup: start timer if value changed
  itemFilter.addEventListener("keyup", () => {
    if (itemFilterValue !== itemFilter.value) {
      clearTimeout(itemFilterTimer);
      itemFilterTimer = setTimeout(itemFilterAction, timeout);
      spinner.style.visibility = "visible";
    }
  });

  // Keydown: cancel timer
  itemFilter.addEventListener("keydown", () => {
    clearTimeout(itemFilterTimer);
    spinner.style.visibility = "hidden";
  });

  // Clear button
  clearButton.addEventListener("click", () => {
    clearButton.style.visibility = "hidden";
    itemFilter.value = "";
    itemFilterAction();
  });

  // Cmd+F shortcut focuses field
  window.addEventListener("keypress", (e) => {
    if (e.metaKey && e.key === "f") {
      if (document.activeElement !== itemFilter) {
        itemFilter.focus();
        e.preventDefault();
      }
    }
  });
});