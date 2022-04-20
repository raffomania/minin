import { initElm } from "../elm";

window.addEventListener("DOMContentLoaded", () => {
    const flags = JSON.parse(window.localStorage.getItem("minin_savegame"));
    const app = initElm({
        flags,
    });

    app.ports.storeModel.subscribe((model) => {
        console.log(model);
        window.localStorage.setItem("minin_savegame", JSON.stringify(model));
    });
});
