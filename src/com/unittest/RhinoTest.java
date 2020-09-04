package com.unittest;

import org.mozilla.javascript.Context;
import org.mozilla.javascript.Function;
import org.mozilla.javascript.Scriptable;

public class RhinoTest {
    public static void main(String[] args) {
        testCallScriptInJava2();
    }

    public static void testCallScriptInJava2() {
        Context context = Context.enter();
        try {
            Scriptable scope = context.initStandardObjects();
            String jsStr = "function showHello(name) {return 'hello ' + name +'!';}";
            context.evaluateString(scope, jsStr, null, 1, null);
            Object functionObject = scope.get("showHello", scope);
            if (!(functionObject instanceof Function)) {
                System.out.println("showHello is undefined or not a function.");
            } else {
                Object args[] = { "Yves" };
                Function test = (Function) functionObject;
                Object result = test.call(context, scope, scope, args);
                System.out.println(Context.toString(result));
            }
        } catch (Exception e) {
        } finally {
            Context.exit();
        }
    }

    public static void testCallScriptInJava() {
        Context context = Context.enter();
        try {
            Scriptable scope = context.initStandardObjects();
            String jsStr = "var name = 'Yves';";
            context.evaluateString(scope, jsStr, null, 1, null);
            Object jsObject = scope.get("name", scope);
            if (jsObject == Scriptable.NOT_FOUND) {
                System.out.println("name is not defined.");
            } else {
                System.out.println("name is " + Context.toString(jsObject));
            }
        } catch (Exception e) {
        } finally {
            Context.exit();
        }
    }
}
