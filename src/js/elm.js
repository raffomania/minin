import { Elm } from "../Main.elm";

export function initElm(opts) {
    const app = Elm.Main.init({
        node: document.getElementById("elm"),
        ...opts,
    });

    return app;
}
