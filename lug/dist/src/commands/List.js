"use strict";
var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
exports.__esModule = true;
var chalk_1 = __importDefault(require("chalk"));
var Command_1 = __importDefault(require("./Command"));
var Kernel_1 = __importDefault(require("../support/Kernel"));
var List = (function (_super) {
    __extends(List, _super);
    function List() {
        var _this = _super !== null && _super.apply(this, arguments) || this;
        _this.name = 'list';
        _this.description = 'List the available commands';
        _this.options = {
            'no-headers': {
                shorthand: 'n',
                description: "Do not print headers"
            }
        };
        return _this;
    }
    List.prototype.handle = function () {
        return __awaiter(this, void 0, void 0, function () {
            var showHeaders, commands, buckets;
            var _this = this;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        showHeaders = !(this.getOption('headers') === false || this.getOption('no-headers'));
                        if (showHeaders) {
                            this.header('Usage:');
                            this.line(this.indent('command [options]'));
                            this.line();
                            this.header('Options:');
                            this.getOptionKeys().forEach(function (opt) { return _this.printOpt(opt); });
                            this.line();
                            this.header('Available Commands:');
                        }
                        return [4, Kernel_1["default"].commands()];
                    case 1:
                        commands = _a.sent();
                        buckets = {};
                        commands.forEach(function (command) {
                            var bucket = command.name.includes(':') ? command.name.split(':')[0] : '';
                            buckets[bucket] = [].concat(command);
                        });
                        Object.keys(buckets).forEach(function (bucket) {
                            if (bucket !== '' && showHeaders) {
                                _this.header(' ' + bucket);
                            }
                            buckets[bucket].forEach(function (command) {
                                var spacing = _this.makeListSpacing(commands.map(function (c) { return c.name; }), command.name);
                                _this.line(_this.indent() + chalk_1["default"].green(command.name) + spacing + chalk_1["default"].white(command.description));
                            });
                        });
                        return [2];
                }
            });
        });
    };
    return List;
}(Command_1["default"]));
exports["default"] = List;
//# sourceMappingURL=List.js.map