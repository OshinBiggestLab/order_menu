const OrderMenuHook = {
  // bindStartNewOrderButton is used here to prevent elements undifined issue
  // (because: when the browser is mounted the element did not exist yet due to the condition I made it was still false, so it couldn't find))
  mounted() {
    this.bindStartNewOrderButton();
  },
  updated() {
    this.bindStartNewOrderButton();
  },
  bindStartNewOrderButton() {
    const order = this.el.querySelector("#start_new_order");

    if (order) {
      order.addEventListener("click", (e) => {
        e.preventDefault();
        const items = JSON.parse(this.el.dataset.items || "[]");
        localStorage.setItem("orders", JSON.stringify(items));

        this.pushEvent("reset_order");

        let orders = JSON.parse(localStorage.getItem("orders") || "[]");
        console.log("Thank you for your order!  ", orders);
      });
    } else {
      console.warn("Button not found");
    }
  },
};

export default OrderMenuHook;
