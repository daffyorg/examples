import React, {Fragment, useRef, useState} from 'react';
import { select, interpolate } from 'd3';
import { Transition, Dialog } from "@headlessui/react";
import Donate from "~/components/donate";
import Gift from "~/components/gift";
import Surprise from "~/components/surprise";

const data = [
    {
        name: "Random donation",
        id: 1,
        description: "You can donate to a random non-profit!"
    },
    {
        name: "Duplicate last donation",
        id: 2,
        description: "Do you want to duplicate your last donation made on Daffy?"
    },
    {
        name: "Challenge a Friend",
        id: 3,
        description: "A random non profit will be picked to invite your friends to donate $20 or more to them"
    },
    {
        name: "The gift of Giving",
        id: 4,
        description: "Gift $20 to a friend"
    },
    {
        name: "Donate & Match with Friends",
        id: 5,
        description: "You can donate to a random non-profit and invite friends to match it"
    },
    {
        name: "Secret Prize",
        id: 6,
        description: ""
    }
];

const Wheel = () => {
    const wheelRef = useRef(null);
    let [result, setResult] = useState(null);
    let [accept, setAccept] = useState(false);

    function resetResult() {
        setResult(null);
        setAccept(false);
    }

    function renderPrize() {
        let MODALS = {
            1: <Donate onClose={resetResult} action="get-non-profit"/>,
            2: <Donate onClose={resetResult} action="get-last-donation"/>,
            3: <Donate onClose={resetResult} action="get-non-profit" challenge/>,
            4: <Gift onClose={resetResult}/>,
            5: <Donate onClose={resetResult} action="get-non-profit" share/>,
            6: <Surprise onClose={resetResult} />,
        }
        return MODALS[result.id] || null;
    }

    function retry() {
        resetResult()
        handleSpinClick()
    }

    const handleSpinClick = () => {
        setAccept(false);
        function getRandomInt(min, max) {
            min = Math.ceil(min);
            max = Math.floor(max);
            return Math.floor(Math.random() * (max - min)) + min;
        }
        const spins = 3;
        const degrees = spins * 360;
        const piedegree = 360 / data.length;
        const randomAssetIndex  = getRandomInt(0, data.length);
        const randomPieMovement = getRandomInt(1, piedegree);
        let rotation = (data.length - randomAssetIndex) * piedegree - randomPieMovement + degrees;

        select(wheelRef.current)
            .selectAll('.wheel')
            .transition()
            .duration(3000)
            .attrTween('transform', rotTween)
            // .ease(d3.easeCircleOut)
            .on('end', function(){
                // console.log('Resultado obtenido:', data[randomAssetIndex].name);
                setResult(data[randomAssetIndex])
            });
        function rotTween() {
            let i = interpolate(0, rotation);
            return function(t) {
                return `rotate(${i(t)})`;
            };
        }
    };

    return (
        <div className="flex flex-col justify-center items-center">
            {result && !accept &&
                <ConfirmModal
                    result={result}
                    onClose={resetResult}
                    setAccept={() => setAccept(true)}
                    onRetry={retry}
                />
            }
            {result && accept && renderPrize()}
            <div ref={wheelRef} >
                <svg width="500" height="500">
                    <g transform="translate(250,250)">
                        <g className="font-medium text-neutral-dark wheel">
                            <g>
                                <path fill="#BDEDDE" d="M0,-230A230,230,0,0,1,199.186,-115L0,0Z"></path>
                                <text fill="currentColor" transform="rotate(-60)translate(220)" textAnchor="end">Random donation</text>
                            </g>
                            <g>
                                <path fill="#CCBEFF" d="M199.186,-115A230,230,0,0,1,199.186,115L0,0Z"></path>
                                <text fill="currentColor" transform="rotate(0)translate(220)" textAnchor="end">Duplicate last donation
                                </text>
                            </g>
                            <g>
                                <path fill="#CBD973" d="M199.186,115A230,230,0,0,1,0,230L0,0Z"></path>
                                <text fill="currentColor" transform="rotate(59.99999999999997)translate(220)" textAnchor="end">Challenge a
                                    Friend
                                </text>
                            </g>
                            <g>
                                <path fill="#BDEDDE" d="M0,230A230,230,0,0,1,-199.186,115L0,0Z"></path>
                                <text fill="currentColor" transform="rotate(119.99999999999997)translate(220)" textAnchor="end">The gift of
                                    Giving
                                </text>
                            </g>
                            <g>
                                <path fill="#CCBEFF" d="M-199.186,115A230,230,0,0,1,-199.186,-115L0,0Z"></path>
                                <text fill="currentColor" transform="rotate(180)translate(220)" textAnchor="end">Donate &amp; Match
                                </text>
                            </g>
                            <g>
                                <path fill="#CBD973" d="M-199.186,-115A230,230,0,0,1,0,-230L0,0Z"></path>
                                <text fill="currentColor" transform="rotate(239.99999999999994)translate(220)" textAnchor="end">Secret Prize &#128064;</text>
                            </g>
                        </g>
                    </g>
                    <g className="arrow" transform="translate(235, 12)">
                        <path d="M0 0 H30 L 15 25.980762113533157Z" style={{fill: "#418B74"}}></path>
                    </g>
                </svg>
            </div>
            <button onClick={handleSpinClick} className="text-white bg-green-dark rounded-md p-3 font-semibold text-lg">Spin the Wheel!</button>
        </div>
    );
};

function ConfirmModal({result, onClose, setAccept, onRetry}) {
   return (
       <Transition appear show as={Fragment}>
        <Dialog
            as="div"
            className="fixed inset-0 z-50 bg-neutral-800 bg-opacity-60 min-h-screen min-h-screen-ios overflow-y-auto overflow-x-hidden"
            onClose={onClose}
        >
            <div className="flex min-h-full items-baseline justify-center -md:items-end">
                <Transition.Child
                    as={Fragment}
                    enter="ease-out duration-300"
                    enterFrom="opacity-0 scale-95"
                    enterTo="opacity-100 scale-100"
                    leave="ease-in duration-200"
                    leaveFrom="opacity-100 scale-100"
                    leaveTo="opacity-0 scale-95"
                >
                    <Dialog.Panel>
                        <div className="space-y-4 mt-10 md:my-20 -md:w-full bg-white md:w-[568px] md:rounded-xl px-5 pt-6 pb-8 md:p-[60px] md:pt-12 rounded-t-lg transition-all transform overflow-hidden">
                            <h2 className="text-3xl font-medium">Congratulations!</h2>
                            <h3 className="text-lg">You got {result.name}</h3>
                            <h4 className="">{result.description}</h4>
                            <div className="space-x-4 mt-2">
                                <button className="p-3 border rounded-md" onClick={onRetry}>Try again</button>
                                <button className="p-3 text-white rounded-md bg-green-dark" onClick={setAccept}>Take me to the prize</button>
                            </div>
                        </div>
                    </Dialog.Panel>
                </Transition.Child>
            </div>
        </Dialog>
    </Transition>
   )
}

export default Wheel;
