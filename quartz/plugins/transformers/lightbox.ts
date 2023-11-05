import { QuartzTransformerPlugin, QuartzTransformerPluginInstance } from "../types";
import { visit } from "unist-util-visit";
import { Node } from "unist";
import { PluggableList } from 'unified';

// Du musst sicherstellen, dass der Typ deines Knotens korrekt ist.
// Ich verwende hier einen Platzhalter, der eventuell ersetzt werden muss.
interface HastNode extends Node {
    tagName?: string;
    properties?: {
        src?: string;
        href?: string;
        className?: string[];
    };
    children?: HastNode[];
}

export const LightboxTransformer: QuartzTransformerPlugin = (): QuartzTransformerPluginInstance => {
    return {
        name: "LightboxTransformer",
        htmlPlugins(): PluggableList {
            return [
                () => {
                    return (tree: HastNode) => {
                        visit(tree, "element", (node: HastNode, index: number | null, parent: HastNode | undefined) => {
                            // Prüfe, ob der Knoten ein <img>-Element ist
                            if (node.tagName === "img" && parent && typeof index === 'number') {
                                // Ersetze das <img>-Element durch ein anklickbares Element, das die Lightbox aktiviert
                                const lightboxNode: HastNode = {
                                    type: 'element',
                                    tagName: 'a',
                                    properties: {
                                        href: node.properties?.src,
                                        className: ["lightbox"],
                                        // Weitere Eigenschaften wie Datenattribute können hier hinzugefügt werden
                                    },
                                    children: [node] // Setze das <img>-Element als Kind des <a>-Elements
                                };

                                // Ersetze das alte Element durch das neue Element
                                parent.children![index] = lightboxNode;
                            }
                        });
                    };
                },
            ];
        },
        externalResources() {
            return {
                css: [require.resolve('lightbox2/dist/css/lightbox.css')],
                js: [
                    {
                        src: require.resolve('lightbox2/dist/js/lightbox.js'),
                        loadTime: 'afterDOMReady',
                        contentType: 'external',
                    },
                ],
            };
        },
    };
};
