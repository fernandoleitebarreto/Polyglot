unit uArrayUtils;

interface

uses
  System.Generics.Defaults;

type
  TArrayUtils<T> = class
  public
    class function Contains(const x: T; const anArray: array of T): boolean;
  end;

implementation

{ TArrayUtils<T> }

class function TArrayUtils<T>.Contains(const x: T; const anArray: array of T): boolean;
var
  y: T;
  lComparer: IEqualityComparer<T>;
begin
  lComparer := TEqualityComparer<T>.Default;
  for y in anArray do
  begin
    if lComparer.Equals(x, y) then
      Exit(True);
  end;
  Exit(False);
end;

end.
