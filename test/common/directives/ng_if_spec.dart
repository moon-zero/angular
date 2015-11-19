library angular2.test.common.directives.ng_if_spec;

import "package:angular2/testing_internal.dart"
    show
        AsyncTestCompleter,
        TestComponentBuilder,
        beforeEach,
        ddescribe,
        describe,
        el,
        expect,
        iit,
        inject,
        it,
        xit;
import "package:angular2/src/core/dom/dom_adapter.dart" show DOM;
import "package:angular2/core.dart" show Component, View;
import "package:angular2/common.dart" show NgIf;
import "package:angular2/src/facade/lang.dart" show IS_DART;

main() {
  describe("ng-if directive", () {
    it(
        "should work in a template attribute",
        inject([TestComponentBuilder, AsyncTestCompleter],
            (TestComponentBuilder tcb, async) {
          var html =
              "<div><copy-me template=\"ng-if booleanCondition\">hello</copy-me></div>";
          tcb
              .overrideTemplate(TestComponent, html)
              .createAsync(TestComponent)
              .then((fixture) {
            fixture.detectChanges();
            expect(DOM
                .querySelectorAll(fixture.debugElement.nativeElement, "copy-me")
                .length).toEqual(1);
            expect(fixture.debugElement.nativeElement).toHaveText("hello");
            async.done();
          });
        }));
    it(
        "should work in a template element",
        inject([TestComponentBuilder, AsyncTestCompleter],
            (TestComponentBuilder tcb, async) {
          var html =
              "<div><template [ng-if]=\"booleanCondition\"><copy-me>hello2</copy-me></template></div>";
          tcb
              .overrideTemplate(TestComponent, html)
              .createAsync(TestComponent)
              .then((fixture) {
            fixture.detectChanges();
            expect(DOM
                .querySelectorAll(fixture.debugElement.nativeElement, "copy-me")
                .length).toEqual(1);
            expect(fixture.debugElement.nativeElement).toHaveText("hello2");
            async.done();
          });
        }));
    it(
        "should toggle node when condition changes",
        inject([TestComponentBuilder, AsyncTestCompleter],
            (TestComponentBuilder tcb, async) {
          var html =
              "<div><copy-me template=\"ng-if booleanCondition\">hello</copy-me></div>";
          tcb
              .overrideTemplate(TestComponent, html)
              .createAsync(TestComponent)
              .then((fixture) {
            fixture.debugElement.componentInstance.booleanCondition = false;
            fixture.detectChanges();
            expect(DOM
                .querySelectorAll(fixture.debugElement.nativeElement, "copy-me")
                .length).toEqual(0);
            expect(fixture.debugElement.nativeElement).toHaveText("");
            fixture.debugElement.componentInstance.booleanCondition = true;
            fixture.detectChanges();
            expect(DOM
                .querySelectorAll(fixture.debugElement.nativeElement, "copy-me")
                .length).toEqual(1);
            expect(fixture.debugElement.nativeElement).toHaveText("hello");
            fixture.debugElement.componentInstance.booleanCondition = false;
            fixture.detectChanges();
            expect(DOM
                .querySelectorAll(fixture.debugElement.nativeElement, "copy-me")
                .length).toEqual(0);
            expect(fixture.debugElement.nativeElement).toHaveText("");
            async.done();
          });
        }));
    it(
        "should handle nested if correctly",
        inject([TestComponentBuilder, AsyncTestCompleter],
            (TestComponentBuilder tcb, async) {
          var html =
              "<div><template [ng-if]=\"booleanCondition\"><copy-me *ng-if=\"nestedBooleanCondition\">hello</copy-me></template></div>";
          tcb
              .overrideTemplate(TestComponent, html)
              .createAsync(TestComponent)
              .then((fixture) {
            fixture.debugElement.componentInstance.booleanCondition = false;
            fixture.detectChanges();
            expect(DOM
                .querySelectorAll(fixture.debugElement.nativeElement, "copy-me")
                .length).toEqual(0);
            expect(fixture.debugElement.nativeElement).toHaveText("");
            fixture.debugElement.componentInstance.booleanCondition = true;
            fixture.detectChanges();
            expect(DOM
                .querySelectorAll(fixture.debugElement.nativeElement, "copy-me")
                .length).toEqual(1);
            expect(fixture.debugElement.nativeElement).toHaveText("hello");
            fixture.debugElement.componentInstance.nestedBooleanCondition =
                false;
            fixture.detectChanges();
            expect(DOM
                .querySelectorAll(fixture.debugElement.nativeElement, "copy-me")
                .length).toEqual(0);
            expect(fixture.debugElement.nativeElement).toHaveText("");
            fixture.debugElement.componentInstance.nestedBooleanCondition =
                true;
            fixture.detectChanges();
            expect(DOM
                .querySelectorAll(fixture.debugElement.nativeElement, "copy-me")
                .length).toEqual(1);
            expect(fixture.debugElement.nativeElement).toHaveText("hello");
            fixture.debugElement.componentInstance.booleanCondition = false;
            fixture.detectChanges();
            expect(DOM
                .querySelectorAll(fixture.debugElement.nativeElement, "copy-me")
                .length).toEqual(0);
            expect(fixture.debugElement.nativeElement).toHaveText("");
            async.done();
          });
        }));
    it(
        "should update several nodes with if",
        inject([TestComponentBuilder, AsyncTestCompleter],
            (TestComponentBuilder tcb, async) {
          var html = "<div>" +
              "<copy-me template=\"ng-if numberCondition + 1 >= 2\">helloNumber</copy-me>" +
              "<copy-me template=\"ng-if stringCondition == 'foo'\">helloString</copy-me>" +
              "<copy-me template=\"ng-if functionCondition(stringCondition, numberCondition)\">helloFunction</copy-me>" +
              "</div>";
          tcb
              .overrideTemplate(TestComponent, html)
              .createAsync(TestComponent)
              .then((fixture) {
            fixture.detectChanges();
            expect(DOM
                .querySelectorAll(fixture.debugElement.nativeElement, "copy-me")
                .length).toEqual(3);
            expect(DOM.getText(fixture.debugElement.nativeElement))
                .toEqual("helloNumberhelloStringhelloFunction");
            fixture.debugElement.componentInstance.numberCondition = 0;
            fixture.detectChanges();
            expect(DOM
                .querySelectorAll(fixture.debugElement.nativeElement, "copy-me")
                .length).toEqual(1);
            expect(fixture.debugElement.nativeElement)
                .toHaveText("helloString");
            fixture.debugElement.componentInstance.numberCondition = 1;
            fixture.debugElement.componentInstance.stringCondition = "bar";
            fixture.detectChanges();
            expect(DOM
                .querySelectorAll(fixture.debugElement.nativeElement, "copy-me")
                .length).toEqual(1);
            expect(fixture.debugElement.nativeElement)
                .toHaveText("helloNumber");
            async.done();
          });
        }));
    if (!IS_DART) {
      it(
          "should not add the element twice if the condition goes from true to true (JS)",
          inject([TestComponentBuilder, AsyncTestCompleter],
              (TestComponentBuilder tcb, async) {
            var html =
                "<div><copy-me template=\"ng-if numberCondition\">hello</copy-me></div>";
            tcb
                .overrideTemplate(TestComponent, html)
                .createAsync(TestComponent)
                .then((fixture) {
              fixture.detectChanges();
              expect(DOM
                  .querySelectorAll(
                      fixture.debugElement.nativeElement, "copy-me")
                  .length).toEqual(1);
              expect(fixture.debugElement.nativeElement).toHaveText("hello");
              fixture.debugElement.componentInstance.numberCondition = 2;
              fixture.detectChanges();
              expect(DOM
                  .querySelectorAll(
                      fixture.debugElement.nativeElement, "copy-me")
                  .length).toEqual(1);
              expect(fixture.debugElement.nativeElement).toHaveText("hello");
              async.done();
            });
          }));
      it(
          "should not recreate the element if the condition goes from true to true (JS)",
          inject([TestComponentBuilder, AsyncTestCompleter],
              (TestComponentBuilder tcb, async) {
            var html =
                "<div><copy-me template=\"ng-if numberCondition\">hello</copy-me></div>";
            tcb
                .overrideTemplate(TestComponent, html)
                .createAsync(TestComponent)
                .then((fixture) {
              fixture.detectChanges();
              DOM.addClass(
                  DOM.querySelector(
                      fixture.debugElement.nativeElement, "copy-me"),
                  "foo");
              fixture.debugElement.componentInstance.numberCondition = 2;
              fixture.detectChanges();
              expect(DOM.hasClass(
                  DOM.querySelector(
                      fixture.debugElement.nativeElement, "copy-me"),
                  "foo")).toBe(true);
              async.done();
            });
          }));
    }
    if (IS_DART) {
      it(
          "should not create the element if the condition is not a boolean (DART)",
          inject([TestComponentBuilder, AsyncTestCompleter],
              (TestComponentBuilder tcb, async) {
            var html =
                "<div><copy-me template=\"ng-if numberCondition\">hello</copy-me></div>";
            tcb
                .overrideTemplate(TestComponent, html)
                .createAsync(TestComponent)
                .then((fixture) {
              expect(() => fixture.detectChanges()).toThrowError();
              expect(DOM
                  .querySelectorAll(
                      fixture.debugElement.nativeElement, "copy-me")
                  .length).toEqual(0);
              expect(fixture.debugElement.nativeElement).toHaveText("");
              async.done();
            });
          }));
    }
  });
}

@Component(selector: "test-cmp")
@View(directives: const [NgIf])
class TestComponent {
  bool booleanCondition;
  bool nestedBooleanCondition;
  num numberCondition;
  String stringCondition;
  Function functionCondition;
  TestComponent() {
    this.booleanCondition = true;
    this.nestedBooleanCondition = true;
    this.numberCondition = 1;
    this.stringCondition = "foo";
    this.functionCondition = (s, n) {
      return s == "foo" && n == 1;
    };
  }
}
