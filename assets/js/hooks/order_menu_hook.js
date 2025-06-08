const OrderMenuHook = {
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

        this.pushEvent("reset-order");

        let orders = JSON.parse(localStorage.getItem("orders") || "[]");
        console.log("Thank you for your order!  ", orders);
      });
    } else {
      console.warn("Button not found");
    }
  },
};

export default OrderMenuHook;
